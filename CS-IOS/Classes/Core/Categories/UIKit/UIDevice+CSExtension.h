//
//  Created by Rene Dohan on 12/26/12.
//


#import <Foundation/Foundation.h>

@interface UIDevice (CSExtension)

+ (BOOL)isPortrait;

+ (BOOL)isLandscape;

+ (BOOL)iPhone;

+ (BOOL)iPad;

+ (BOOL)isWideScreen;

+ (float)systemVersion;

+ (BOOL)isIOS8;

+ (BOOL)isIOS7;

+ (BOOL)isIOS10;

+ (BOOL)isIOS11;
@end