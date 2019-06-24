//
//  Created by Rene Dohan on 12/26/12.
//

@import UIKit;

@interface UIDevice (CSExtension)

+ (void)setOrientation:(UIDeviceOrientation)orientation;

+ (UIDeviceOrientation)orientation;

+ (UIInterfaceOrientation)statusBarOrientation;

+ (BOOL)isPortrait;

+ (BOOL)isLandscape;

+ (BOOL)iPhone;

+ (BOOL)iPad;

+ (BOOL)isShortScreen;

+ (BOOL)isTallScreen;

+ (BOOL)isThinScreen;

+ (BOOL)isWideScreen;

+ (float)systemVersion;

+ (BOOL)isIOS10;

+ (BOOL)isIOS11;
@end
