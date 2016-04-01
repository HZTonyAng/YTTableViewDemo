
#import "FacebookStyleBarBehaviorDefiner.h"

#import "BLKFlexibleHeightBar.h"

@interface FacebookStyleBarBehaviorDefiner ()

@property (nonatomic) CGFloat previousYOffset;
@property (nonatomic) CGFloat previousProgress;

@end

@implementation FacebookStyleBarBehaviorDefiner

- (instancetype)init
{
    if(self = [super init])
    {
        _previousYOffset = 0.0;
        _previousProgress = 0.0;
        
        _thresholdFromTop = 0.0;
        _thresholdNegativeDirection = 0.0;
        _thresholdPositiveDirection = 0.0;
        
        self.elasticMaximumHeightAtTop = NO;
    }
    
    return self;
}

- (void)setThresholdFromTop:(CGFloat)thresholdFromTop
{
    _thresholdFromTop = fmax(thresholdFromTop, 0.0);
}

- (void)setThresholdNegativeDirection:(CGFloat)thresholdNegativeDirection
{
    _thresholdNegativeDirection = fmax(thresholdNegativeDirection, 0.0);
}


- (void)setThresholdPositiveDirection:(CGFloat)thresholdPositiveDirection
{
    _thresholdPositiveDirection = fmax(thresholdPositiveDirection, 0.0);
}


# pragma mark - Thresholds

- (void)applyFromTopProgressTrackingThreshold
{
    self.previousYOffset += self.thresholdFromTop;
}

- (void)applyNegativeDirectionProgressTrackingThreshold
{
    if(self.flexibleHeightBar.progress == 1.0)
    {
        self.previousYOffset -= self.thresholdNegativeDirection;
    }
}

- (void)applyPositiveDirectionProgressTrackingThreshold
{
    if(self.flexibleHeightBar.progress == 0.0)
    {
        self.previousYOffset += self.thresholdPositiveDirection;
    }
}


# pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    CGFloat scrollViewViewportHeight = CGRectGetMaxY(scrollView.bounds) - CGRectGetMinY(scrollView.bounds);
    
    if((scrollView.contentOffset.y+scrollView.contentInset.top) >= 0.0 && scrollView.contentOffset.y <= (scrollView.contentSize.height-scrollViewViewportHeight))
    {
        self.previousYOffset = scrollView.contentOffset.y;
        self.previousProgress = self.flexibleHeightBar.progress;
        
        // Apply top threshold
        if((scrollView.contentOffset.y+scrollView.contentInset.top) == 0.0)
        {
            [self applyFromTopProgressTrackingThreshold];
        }
        else
        {
//            // Edge case (not true) - user is scrolling to the top but there isn't enough runway left to pass the threshold
            if((scrollView.contentOffset.y+scrollView.contentInset.top) > (self.thresholdNegativeDirection+(self.flexibleHeightBar.maximumBarHeight-self.flexibleHeightBar.minimumBarHeight)))
            {
                [self applyNegativeDirectionProgressTrackingThreshold];
            }
            
            // Edge case (not true) - user is scrolling to the bottom but there isn't enough runway left to pass the threshold
            if(scrollView.contentOffset.y < (scrollView.contentSize.height-scrollViewViewportHeight-self.thresholdPositiveDirection))
            {
                [self applyPositiveDirectionProgressTrackingThreshold];
            }
        }
    }
    // Edge case - user starts to scroll while the scroll view is stretched above the top
    else if((scrollView.contentOffset.y+scrollView.contentInset.top) < 0.0)
    {
        self.previousYOffset = -scrollView.contentInset.top;
        self.previousProgress = 0.0;
        
        if(self.thresholdFromTop != 0.0)
        {
            [self applyFromTopProgressTrackingThreshold];
        }
        else
        {
            [self applyNegativeDirectionProgressTrackingThreshold];
            [self applyPositiveDirectionProgressTrackingThreshold];
        }
    }
    // Edge case - user starts to scroll while the scroll view is stretched below the bottom
    else if(scrollView.contentOffset.y > (scrollView.contentSize.height-scrollViewViewportHeight))
    {
        if(scrollView.contentSize.height > scrollViewViewportHeight)
        {
            self.previousYOffset = scrollView.contentSize.height - scrollViewViewportHeight;
            self.previousProgress = 1.0;
            
            [self applyNegativeDirectionProgressTrackingThreshold];
            [self applyPositiveDirectionProgressTrackingThreshold];
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [super scrollViewDidScroll:scrollView];
    
    if(!self.isCurrentlySnapping)
    {
        CGFloat deltaYOffset = scrollView.contentOffset.y - self.previousYOffset;
        CGFloat deltaProgress = deltaYOffset / (self.flexibleHeightBar.maximumBarHeight-self.flexibleHeightBar.minimumBarHeight);
        
        self.flexibleHeightBar.progress = self.previousProgress + deltaProgress;
        
        [self.flexibleHeightBar setNeedsLayout];
    }
}


@end
