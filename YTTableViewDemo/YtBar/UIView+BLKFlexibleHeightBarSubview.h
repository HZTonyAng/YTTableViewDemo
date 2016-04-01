

#import <UIKit/UIKit.h>

@class BLKFlexibleHeightBarSubviewLayoutAttributes;


@interface UIView (BLKFlexibleHeightBarSubview)

/**
 Add layout attributes that correspond to a progress value.
 @param The layout attributes that the receiver wants to be applied to itself.
 @param The progress value (between 0.0 and 1.0 inclusive) that the receiver's containing `BLKFlexibleHeightBar` instance will use to decide which layout attributes to apply.
 */
- (void)addLayoutAttributes:(BLKFlexibleHeightBarSubviewLayoutAttributes *)layoutAttributes forProgress:(CGFloat)progress;

/**
 Remove the layout attributes instance that corresponds to then specified progress value.
 @param The progress value corresponding to the layout attributes that are to be removed.
 */
- (void)removeLayoutAttributesForProgress:(CGFloat)progress;

/**
 Returns the number of layout attributes currently associated with the receiver.
 @return The number of layout attributes currently associated with the receiver.
 */
- (NSUInteger)numberOfLayoutAttributes;

/**
 Returns the progress value corresponding to the specified index. This is a helper method for `BLKFlexibleHeightBar.`
 @param The index of the desired progress value.
 @return The progress value corresponding to the specified index.
 */
- (CGFloat)progressAtIndex:(NSUInteger)index;

/**
 Returns the layout attributes corresponding to the specified index. This is a helper method for `BLKFlexibleHeightBar.`
 @param The index of the desired layout attributes.
 @return The layout attributes corresponding to the specified index.
 */
- (BLKFlexibleHeightBarSubviewLayoutAttributes *)layoutAttributesAtIndex:(NSUInteger)index;

@end
