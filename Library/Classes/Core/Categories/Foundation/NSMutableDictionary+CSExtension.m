//
//  Created by Rene Dohan on 5/3/12.
//
#import "CSLang.h"
#import "NSMutableDictionary+CSExtension.h"
#import "NSObject+CSExtension.h"


@implementation NSMutableDictionary (CSExtension)

- (instancetype)construct:(NSDictionary *)dictionary {
    [super construct];
    [self addEntriesFromDictionary:dictionary];
    return self;
}

- (instancetype)put:(NSDictionary *)dictionary {
    [self addEntriesFromDictionary:dictionary];
    return self;
}

- (instancetype)putBool:(BOOL)value forKey:(NSString *)key {
    [self setValue:@(value) forKey:key];
    return self;
}

- (instancetype)put:(id)key :(id)value {
    self[key] = nilToNull(value);
    return self;
}

@end
