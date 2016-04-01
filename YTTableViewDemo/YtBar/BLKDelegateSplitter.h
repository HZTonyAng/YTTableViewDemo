
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface BLKDelegateSplitter : NSObject <NSObject>

/**
 The first delegate.
 */
@property (nonatomic, weak) id<NSObject> firstDelegate;

/**
 The second delegate.
 */
@property (nonatomic, weak) id<NSObject> secondDelegate;

/**
 A convenience initializer that sets the first and second delegate.
 @param The existing layout attributes.
 @return A delegate splitter instance, or nil of initialization fails.
 */
- (instancetype)initWithFirstDelegate:(id<NSObject>)firstDelegate secondDelegate:(id<NSObject>)secondDelegate;

@end
