

#import <UIKit/UIKit.h>

#import "BLKFlexibleHeightBarBehaviorDefiner.h"
#import "BLKFlexibleHeightBarSubviewLayoutAttributes.h"
#import "UIView+BLKFlexibleHeightBarSubview.h"


@interface BLKFlexibleHeightBar : UIView

/**
 The current progress, representing how much the bar has shrunk. progress == 0.0 puts the bar at its maximum height. progress == 1.0 puts the bar at its minimum height. The default value is 0.0.
 @warning `progress` is bounded between 0.0 and 1.0 inclusive unless the bar's `behaviorDefiner` instance has its `elasticMaximumHeightAtTop` set to YES.
 */
@property (nonatomic) CGFloat progress;

/**
 The non-negative maximum height for the bar. The default value is 44.0.
 */
@property (nonatomic) CGFloat maximumBarHeight;

/**
 The non-negative minimum height for the bar. The default value is 20.0.
 */
@property (nonatomic) CGFloat minimumBarHeight;

/**
 The behavior definer for the bar. Behavior definers are instances of `BLKFlexibleHeightBarBehaviorDefiner.` Behavior definers can be changed at run time to provide a different behavior.
 */
@property (nonatomic) BLKFlexibleHeightBarBehaviorDefiner *behaviorDefiner;

@end
