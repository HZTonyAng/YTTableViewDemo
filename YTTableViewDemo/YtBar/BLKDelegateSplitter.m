

#import "BLKDelegateSplitter.h"

@implementation BLKDelegateSplitter

- (instancetype)initWithFirstDelegate:(id<NSObject>)firstDelegate secondDelegate:(id<NSObject>)secondDelegate
{
    if(self = [super init])
    {
        _firstDelegate = firstDelegate;
        _secondDelegate = secondDelegate;
    }
    
    return self;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    SEL aSelector = [anInvocation selector];
    
    if([self.firstDelegate respondsToSelector:aSelector])
    {
        [anInvocation invokeWithTarget:self.firstDelegate];
    }
    
    if([self.secondDelegate respondsToSelector:aSelector])
    {
        [anInvocation invokeWithTarget:self.secondDelegate];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSMethodSignature *first = [(NSObject *)self.firstDelegate methodSignatureForSelector:aSelector];
    NSMethodSignature *second = [(NSObject *)self.secondDelegate methodSignatureForSelector:aSelector];
    
    if(first)
    {
        return first;
    }
    else if(second)
    {
        return second;
    }
    
    return nil;
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    if([self.firstDelegate respondsToSelector:aSelector] || [self.secondDelegate respondsToSelector:aSelector])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

@end