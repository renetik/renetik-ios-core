//
// Created by inno on 2/12/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "NSException+CSExtension.h"


@implementation NSException (CSExtension)

+ (NSException *)exceptionWithName:(NSString *)name {
    return [self exceptionWithName:name reason:@"" userInfo:nil];
}

@end