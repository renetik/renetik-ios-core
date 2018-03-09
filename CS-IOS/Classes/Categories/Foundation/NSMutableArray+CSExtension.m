//
//  Created by Rene Dohan on 6/5/12.
//

#import "CSLang.h"
#import "NSArray+CSExtension.h"
#import "NSMutableArray+CSExtension.h"
#import "NSObject+CSExtension.h"
#import "CSCocoaLumberjack.h"


@implementation NSMutableArray (CSExtension)

- (instancetype)construct:(NSArray *)array {
    [super construct];
    [self addArray:array];
    return self;
}

- (id)objectAtIndexedSubscript:(NSUInteger)idx {
    return [self at:idx];
}

- (id)add:(id)anObject {
    [self addObject:anObject];
    return anObject;
}

- (id)set:(id)anObject {
    if (![self containsObject:anObject]) [self addObject:anObject];
    return anObject;
}

- (id)add:(id)anObject :(NSUInteger)index {
    [self insertObject:anObject atIndex:index];
    return anObject;
}

- (id)replaceObject:(id)newObject :(id)oldObject {
    NSUInteger oldIndex = [self indexOfObject:oldObject];
    if (oldIndex == NSNotFound) warnf(@"oldObject on found for replace %@", oldObject);
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

- (instancetype)replaceFromArray:(NSArray *)array {
    [self removeAllObjects];
    [self addObjectsFromArray:array];
    return self;
}


@end
