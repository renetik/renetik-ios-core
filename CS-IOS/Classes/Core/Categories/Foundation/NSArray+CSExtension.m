//
//  Created by Rene Dohan on 5/9/12.
//

#import "CSLang.h"

@implementation NSArray (CSExtension)

//- (id)objectAtIndexedSubscript:(NSUInteger)idx {
//    return [self at:idx];
//}

- (id)objectAs:(id)anObject {
    NSUInteger index = [self indexOf:anObject];
    if (index != NSNotFound) return self[index];
    return nil;
}

- (BOOL)contains:(id)anObject {
    return [self containsObject:anObject];
}

- (NSUInteger)indexOf:(id)anObject {
    return [self indexOfObject:anObject];
}

- (id)at:(NSInteger)index {
    return index < self.count ? nullToNil(self[(NSUInteger) index]) : nil;
}

- (id)get:(NSInteger)index {
    return [self at:index];
}

- (BOOL)empty {
    return self.count == 0;
}

- (BOOL)hasItems {
    return !self.empty;
}

- (id)last {
    return [self at:self.lastIndex];
}

- (id)first {
    return [self at:0];
}

- (id)second {
    return [self at:1];
}

- (NSInteger)lastIndex {
    return self.count - 1;
}

- (NSInteger)size {
    return self.count;
}

- (BOOL)equals:(NSArray<id <NSObject>> *)array {
    for (uint i = 0; i < self.count; i++)
        if (![self[i] isEqual:array[i]]) return NO;
    return YES;
}

- (BOOL)set {
    return self.size > 0;
}
@end
