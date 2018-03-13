//
// Created by inno on 2/11/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "NSNumber+CSExtension.h"


@implementation NSNumber (CSExtension)

+ (NSNumber *)numberWithString:(NSString *)value {
    if (value)return @(value.intValue);
    return nil;
}
@end