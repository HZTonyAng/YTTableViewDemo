

#import "UIView+BLKFlexibleHeightBarSubview.h"

// Needed to enable custom properties to a category - see http://nshipster.com/associated-objects/
#import <objc/runtime.h>

@interface UIView (_BLKFlexibleHeightBarSubview)

@property (nonatomic) NSMutableArray *progressValues;
@property (nonatomic) NSMutableArray *layoutAttributesForProgressValues;

@end

@implementation UIView (_BLKFlexibleHeightNavigationBarSubview)

// Needed to enable custom properties to a category - see http://nshipster.com/associated-objects/
# pragma mark - Voodoo :)

- (NSMutableArray *)progressValues
{
    return (NSMutableArray *)objc_getAssociatedObject(self, @selector(progressValues));
}

- (void)setProgressValues:(NSMutableArray *)progressValues
{
    objc_setAssociatedObject(self, @selector(progressValues), progressValues, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)layoutAttributesForProgressValues
{
    return (NSMutableArray *)objc_getAssociatedObject(self, @selector(layoutAttributesForProgressValues));
}

- (void)setLayoutAttributesForProgressValues:(NSMutableArray *)layoutAttributesForProgressValues
{
    objc_setAssociatedObject(self, @selector(layoutAttributesForProgressValues), layoutAttributesForProgressValues, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


# pragma mark - Add and remove layout attributes

- (void)addLayoutAttributes:(BLKFlexibleHeightBarSubviewLayoutAttributes *)layoutAttributes forProgress:(CGFloat)progress;
{
    // Lazily init arrays
    if(!self.progressValues)
    {
        self.progressValues = [[NSMutableArray alloc] init];
    }
    if(!self.layoutAttributesForProgressValues)
    {
        self.layoutAttributesForProgressValues = [[NSMutableArray alloc] init];
    }
    
    // Make sure the progressPosition is between 0 and 1
    progress = fmax(fmin(progress, 1.0), 0.0);
    
    // If layout attributes for this progressPosition already exists, just replace it
    [self.progressValues enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        NSNumber *existingDoubleValue = obj;
        CGFloat existingDouble = [existingDoubleValue doubleValue];
        
        if(existingDouble == progress)
        {
            [self.layoutAttributesForProgressValues replaceObjectAtIndex:idx withObject:layoutAttributes];
            return;
        }
        
    }];
    
    // Insert element at correct position so that it stays sorted
    __block NSUInteger insertionIndex = 0;
    [self.progressValues enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        NSNumber *existingDoubleValue = obj;
        CGFloat existingDouble = [existingDoubleValue doubleValue];
        
        if(progress > existingDouble)
        {
            insertionIndex++;
        }
        else
        {
            *stop = YES;
        }
        
    }];
    
    
    [self.progressValues insertObject:[NSNumber numberWithDouble:progress] atIndex:insertionIndex];
    [self.layoutAttributesForProgressValues insertObject:layoutAttributes atIndex:insertionIndex];
}

- (void)removeLayoutAttributesForProgress:(CGFloat)progress
{
    NSInteger indexToRemove = [self.progressValues indexOfObject:[NSNumber numberWithDouble:progress]];
    
    if(indexToRemove != NSNotFound)
    {
        [self.progressValues removeObjectAtIndex:indexToRemove];
        [self.layoutAttributesForProgressValues removeObjectAtIndex:indexToRemove];
    }
}


# pragma mark - Private property accessors

- (NSUInteger)numberOfLayoutAttributes
{
    return self.layoutAttributesForProgressValues.count;
}

- (CGFloat)progressAtIndex:(NSUInteger)index
{
    NSNumber *progressValue = [self.progressValues objectAtIndex:index];
    return [progressValue doubleValue];
}

- (BLKFlexibleHeightBarSubviewLayoutAttributes *)layoutAttributesAtIndex:(NSUInteger)index
{
    return [self.layoutAttributesForProgressValues objectAtIndex:index];
}

@end
