//
// Created by inno on 2/12/13.
//
// To change the template use AppCode | Preferences | File Templates.
//

@import Foundation;

@interface NSException (CSExtension)
+ (instancetype)exceptionWithName:(NSString *)name;

+ (instancetype)abstractNotImplemented;
@end