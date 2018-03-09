//
//  Created by Rene Dohan on 5/3/12.
//


#import <Foundation/Foundation.h>

@interface NSMutableDictionary<KeyType, ObjectType> (CSExtension)

- (instancetype)construct:(NSDictionary <KeyType, ObjectType> *)dictionary;

- (void)add:(NSDictionary *)dictionary;

- (void)setBool:(BOOL)value forKey:(NSString *)key;

- (void)put:(id)key :(id)value;

@end