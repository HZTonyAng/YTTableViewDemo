

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class BLKFlexibleHeightBar;


@interface BLKFlexibleHeightBarBehaviorDefiner : NSObject <UIScrollViewDelegate>

/**
 The `BLKFlexibleHeightBar` instance corresponding with the behavior definer.
 */
@property (nonatomic, readonly, weak) BLKFlexibleHeightBar *flexibleHeightBar;

/**
 Determines whether snapping is enabled or not. Default value is YES.
 */
@property (nonatomic, getter=isSnappingEnabled) BOOL snappingEnabled;

/**
 Determines whether the bar is current snapping or not.
 */
@property (nonatomic, getter=isCurrentlySnapping) BOOL currentlySnapping;

/**
 Determines whether the bar can stretch to larger sizes than it's `maximumBarHeight`. Default value is NO.
 */
@property (nonatomic, getter=isElasticMaximumHeightAtTop) BOOL elasticMaximumHeightAtTop;


/**
 Add a progress position that the bar will snap to whenever a user stops scrolling and the bar's current progress falls within the specified progress range.
 @param The progress position that the bar will snap to.
 @param The range of progress percents (between 0.0 and 1.0 inclusive) that will cause the bar to snap to the specified `progressPosition.`
 */
- (void)addSnappingPositionProgress:(CGFloat)progress forProgressRangeStart:(CGFloat)start end:(CGFloat)end;

/**
 Removes the progress position corresponding to the specified progress range.
 @param The range of progress percents (between 0.0 and 1.0 inclusive) that correspond with the `progressPosition` that is to be removed.
 */
- (void)removeSnappingPositionProgressForProgressRangeStart:(CGFloat)start end:(CGFloat)end;

/**
 Snap to the specified progress position.
 @param The progress position that the bar will snap to.
 @param The UIScrollView whose offset will be adjusted during the snap.
 */
- (void)snapToProgress:(CGFloat)progress scrollView:(UIScrollView *)scrollView;

/**
 Snap to the appropriate progress position based on the bar's current progress and the currently defined snapping position progresses.
 @param The UIScrollView whose offset will be adjusted during the snap.
 */
- (void)snapWithScrollView:(UIScrollView *)scrollView;


/**
 A UIScrollViewDelegate method implementation that facilitates snapping behavior.
 Subclass implementations should call super's implementation.
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;

/**
 A UIScrollViewDelegate method implementation that facilitates snapping behavior.
 Subclass implementations should call super's implementation.
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;

/**
 A UIScrollViewDelegate method implementation that provides basic UIScrollView indicator inset correction.
 Subclass implementations should call super's implementation.
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

@end
