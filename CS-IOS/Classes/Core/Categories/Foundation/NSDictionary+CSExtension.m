//
//  Created by Rene Dohan on 4/29/12.
//


#import "NSDictionary+CSExtension.h"

@implementation NSDictionary (CSExtension)

+ (id)put:(id)key :(id)object {
    return [self dictionaryWithObject:object forKey:key];
}

+ (id)put:(id)key1 :(id)object1 put:(id)key2 :(id)object2 {
    return [self dictionaryWithObjects:@[object1, object2]
                               forKeys:@[key1, key2]];
}

+ (id)put:(id)key1 :(id)object1 put:(id)key2 :(id)object2 put:(id)key3 :(id)object3 {
    return [self dictionaryWithObjects:@[object1, object2, object3]
                               forKeys:@[key1, key2, key3]];
}

+ (id)put:(id)key1 :(id)object1 put:(id)key2 :(id)object2 put:(id)key3 :(id)object3 put:(id)key4 :(id)object4 {
    return [self dictionaryWithObjects:@[object1, object2, object3, object4]
                               forKeys:@[key1, key2, key3, key4]];
}

+ (NSMutableDictionary *)dictionaryWithDictionaries:(NSArray *)array {
    NSMutableDictionary *dictionary = NSMutableDictionary.new;
    for (NSDictionary *child in array)
        [dictionary addEntriesFromDictionary:child];
    return dictionary;
}

- (id)get:(NSString *)key {
    return self[key];
}

- (BOOL)contains:(NSString *)key {
    return self[key] != nil;
}

@end
