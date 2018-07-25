//
//  Created by Rene Dohan on 4/29/12.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (CSExtension)

+ (id)put:(id)key :(id)object;

+ (id)put:(id)key1 :(id)object1 put:(id)key2 :(id)object2;

+ (id)put:(id)key1 :(id)object1 put:(id)key2 :(id)object2 put:(id)key3 :(id)object3;

+ (id)put:(id)key1 :(id)object1 put:(id)key2 :(id)object2 put:(id)key3 :(id)object3 put:(id)key4 :(id)object4;

+ (NSMutableDictionary *)dictionaryWithDictionaries:(NSArray *)array;

- (id)get:(NSString *)key;

- (BOOL)contains:(NSString *)key;

- (NSString *)jsonString;

@end
