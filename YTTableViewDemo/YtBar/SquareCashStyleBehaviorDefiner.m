

#import "SquareCashStyleBehaviorDefiner.h"

#import "BLKFlexibleHeightBar.h"

@implementation SquareCashStyleBehaviorDefiner


# pragma mark - UIScrollViewDelegate methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [super scrollViewDidScroll:scrollView];
    
    if(!self.isCurrentlySnapping)
    {
        CGFloat progress = (scrollView.contentOffset.y+scrollView.contentInset.top) / (self.flexibleHeightBar.maximumBarHeight-self.flexibleHeightBar.minimumBarHeight);
        self.flexibleHeightBar.progress = progress;
        [self.flexibleHeightBar setNeedsLayout];
    }
}

@end
