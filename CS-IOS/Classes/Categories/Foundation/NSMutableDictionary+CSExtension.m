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

- (void)add:(NSDictionary *)dictionary {
    [self addEntriesFromDictionary:dictionary];
}

- (void)setBool:(BOOL)value forKey:(NSString *)key {
    [self setValue:@(value) forKey:key];
}

- (void)put:(id)key :(id)value {
    if (!value) value = [NSNull null];
    self[key] = value;
}

@end
