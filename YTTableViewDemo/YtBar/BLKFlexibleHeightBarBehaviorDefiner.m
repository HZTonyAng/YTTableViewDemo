

#import "BLKFlexibleHeightBarBehaviorDefiner.h"

#import "BLKFlexibleHeightBar.h"

@interface BLKFlexibleHeightBarBehaviorDefiner ()

@property (nonatomic) NSMutableDictionary *snappingPositionsForProgressRanges;

- (void)BLK_Private_setFlexibleHeightBar:(BLKFlexibleHeightBar *)flexibleHeightBar;

@end

@implementation BLKFlexibleHeightBarBehaviorDefiner

- (instancetype)init
{
    if(self = [super init])
    {
        _snappingPositionsForProgressRanges = [[NSMutableDictionary alloc] init];
        _snappingEnabled = YES;
        _currentlySnapping = NO;
        _elasticMaximumHeightAtTop = NO;
    }
    
    return self;
}

- (void)BLK_Private_setFlexibleHeightBar:(BLKFlexibleHeightBar *)flexibleHeightBar
{
    if(_flexibleHeightBar != flexibleHeightBar)
    {
        _flexibleHeightBar = flexibleHeightBar;
    }
}


# pragma mark - Snapping

- (void)addSnappingPositionProgress:(CGFloat)progress forProgressRangeStart:(CGFloat)start end:(CGFloat)end
{
    // Make sure start and end are between 0 and 1
    start = fmax(fmin(start, 1.0), 0.0) * 100.0;
    end = fmax(fmin(end, 1.0), 0.0) * 100.0;
    NSRange progressPercentRange = NSMakeRange(start, end-start);
    
    [self.snappingPositionsForProgressRanges enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        NSValue *existingRangeValue = key;
        NSRange existingRange = [existingRangeValue rangeValue];
        
        BOOL noRangeConflict = (NSIntersectionRange(progressPercentRange, existingRange).length == 0);
        NSAssert(noRangeConflict, @"progressPercentRange sent to -addSnappingProgressPosition:forProgressPercentRange: intersects a progressPercentRange for an existing progressPosition.");
    }];
    
    NSValue *progressPercentRangeValue = [NSValue valueWithRange:progressPercentRange];
    NSNumber *progressPositionValue = [NSNumber numberWithDouble:progress];
    
    [self.snappingPositionsForProgressRanges setObject:progressPositionValue forKey:progressPercentRangeValue];
}

- (void)removeSnappingPositionProgressForProgressRangeStart:(CGFloat)start end:(CGFloat)end
{
    // Make sure start and end are between 0 and 1
    start = fmax(fmin(start, 1.0), 0.0) * 100.0;
    end = fmax(fmin(end, 1.0), 0.0) * 100.0;
    NSRange progressPercentRange = NSMakeRange(start, end-start);
    
    NSValue *progressPercentRangeValue = [NSValue valueWithRange:progressPercentRange];
    
    [self.snappingPositionsForProgressRanges removeObjectForKey:progressPercentRangeValue];
}

- (void)snapToProgress:(CGFloat)progress scrollView:(UIScrollView *)scrollView
{
    CGFloat deltaProgress = progress - self.flexibleHeightBar.progress;
    CGFloat deltaYOffset = (self.flexibleHeightBar.maximumBarHeight-self.flexibleHeightBar.minimumBarHeight) * deltaProgress;
    scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y+deltaYOffset);
    
    self.flexibleHeightBar.progress = progress;
    [self.flexibleHeightBar setNeedsLayout];
    [self.flexibleHeightBar layoutIfNeeded];
    
    self.currentlySnapping = NO;
}

- (void)snapWithScrollView:(UIScrollView *)scrollView
{
    if(!self.isCurrentlySnapping && self.isSnappingEnabled && self.flexibleHeightBar.progress >= 0.0)
    {
        self.currentlySnapping = YES;
        
        __block CGFloat snapPosition = MAXFLOAT;
        [self.snappingPositionsForProgressRanges enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            
            NSValue *existingRangeValue = key;
            NSRange existingRange = [existingRangeValue rangeValue];
            
            CGFloat progressPercent = self.flexibleHeightBar.progress * 100.0;
            
            if(progressPercent >= existingRange.location && (progressPercent <= (existingRange.location+existingRange.length)))
            {
                NSNumber *existingProgressValue = obj;
                snapPosition = [existingProgressValue doubleValue];
            }
            
        }];
        
        if(snapPosition != MAXFLOAT)
        {
            [UIView animateWithDuration:0.15 animations:^{
                
                [self snapToProgress:snapPosition scrollView:scrollView];
                
            }completion:^(BOOL finished) {
                
                self.currentlySnapping= NO;
                
            }];
        }
        else
        {
            self.currentlySnapping= NO;
        }
    }
}


# pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self snapWithScrollView:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(!decelerate)
    {
        [self snapWithScrollView:scrollView];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    scrollView.scrollIndicatorInsets =  UIEdgeInsetsMake(CGRectGetHeight(self.flexibleHeightBar.bounds), scrollView.scrollIndicatorInsets.left, scrollView.scrollIndicatorInsets.bottom, scrollView.scrollIndicatorInsets.right);
}

@end
