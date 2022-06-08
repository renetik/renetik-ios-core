//
//  Created by Rene Dohan on 5/9/12.
//

#import "CSLang.h"
#import "NSString+CSExtension.h"
#import "NSMutableArray+CSExtension.h"
#import "CSCocoaLumberjack.h"
#import "NSArray+CSExtension.h"

@implementation NSArray (CSExtension)

+ (NSArray<NSString *> *)toStringList:(NSArray<NSObject *> *)names {
    let strings = NSMutableArray.new;
    for (NSObject *object in names)[strings addObject:object.description];
    return strings;
}

+ (NSArray<NSNumber *> *)toNumberList:(NSArray<NSObject *> *)stringList {
    let intList = NSMutableArray.new;
    for (NSObject *object in stringList) [intList put:@(object.description.intValue)];
    return intList;
}

- (id)objectAs:(id)anObject {
    let index = [self indexOf:anObject];
    if (index != NSNotFound) return self[index];
    return nil;
}

- (BOOL)contains:(id)anObject {
    return [self containsObject:anObject];
}

- (NSInteger)indexOf:(id)anObject {
    return [self indexOfObject:anObject];
}

- (id)at:(NSInteger)index {
    return index < self.count ? nullToNil(self[(NSUInteger) index]) : nil;
}

- (id)get:(NSInteger)index {
    return [self at:index];
}

- (id)getPreviousOf:(id)anObject {
    return [self at:[self indexOf:anObject] - 1];
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

- (id)beforeLast {
    return [self at:self.lastIndex - 1];
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

- (NSArray *)filterBySearch:(NSString *)searchText {
    if (searchText.set) {
        let filtered = NSMutableArray.new;
        for (id item in self) if ([[item description] containsNoCase:searchText]) [filtered put:item];
        return filtered;
    }
    return self;
}

- (NSString *)jsonString {
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:nil error:&error];
    warn(error);
    return [NSString.alloc initWithData:data encoding:NSUTF8StringEncoding];
}

- (NSMutableArray *)mutable {
    return [NSMutableArray.new construct:self];
}

@end
