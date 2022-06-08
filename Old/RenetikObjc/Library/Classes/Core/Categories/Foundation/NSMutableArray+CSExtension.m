//
//  Created by Rene Dohan on 6/5/12.
//

#import "CSLang.h"
#import "NSMutableArray+CSExtension.h"
#import "NSObject+CSExtension.h"

@implementation NSMutableArray (CSExtension)

- (instancetype)construct:(NSArray *)array {
    [self addArray:array];
    return self;
}

- (id)put:(id)anObject {
    [self addObject:anObject];
    return anObject;
}

- (id)set:(id)anObject {
    if (![self containsObject:anObject]) [self addObject:anObject];
    return anObject;
}

- (id)add:(id)anObject :(NSUInteger)index {
    [self insertObject:nilToNull(anObject) atIndex:index];
    return anObject;
}

- (id)set:(id)anObject :(NSUInteger)index {
    if (self.count >= index + 1) self[index] = anObject;
    else [self addObject:anObject];
    return anObject;
}

- (id)replaceObject:(id)newObject :(id)oldObject {
    NSUInteger oldIndex = [self indexOfObject:oldObject];
    if (oldIndex == NSNotFound) NSLog(@"oldObject on found for replace %@", oldObject);
    else self[oldIndex] = newObject;
    return newObject;
}

- (instancetype)addArray:(NSArray *)array {
    [self addObjectsFromArray:array];
    return self;
}

- (instancetype)remove:(id)anObject {
    [self removeObject:anObject];
    return self;
}

- (instancetype)removeAll:(NSArray *)array {
    [self removeObjectsInArray:array];
    return self;
}

- (instancetype)reload:(NSArray *)array {
    [self removeAllObjects];
    [self addObjectsFromArray:array];
    return self;
}

- (instancetype)reverse {
    return self.reverseObjectEnumerator.allObjects.mutableCopy;
}

- (instancetype)removeLast {
    [self removeLastObject];
    return self;
}

- (NSString *)joinBy:(NSString *)string {
    return [self componentsJoinedByString:string];
}
@end
