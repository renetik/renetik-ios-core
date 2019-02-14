//
//  Created by Rene Dohan on 5/3/12.
//

@import Foundation;

@interface NSMutableDictionary<KeyType, ObjectType> (CSExtension)

- (instancetype)construct:(NSDictionary <KeyType, ObjectType> *)dictionary;

- (instancetype)put:(NSDictionary *)dictionary;

- (instancetype)putBool:(BOOL)value forKey:(NSString *)key;

- (instancetype)put:(id)key :(id)value;

@end