//
//  Created by Rene Dohan on 12/26/12.
//


#import <UIKit/UIKit.h>

@implementation UIDevice (CSExtension)

+ (BOOL)isPortrait {
    if (self.currentDevice.orientation == UIDeviceOrientationUnknown)
        return UIScreen.mainScreen.bounds.size.width < UIScreen.mainScreen.bounds.size.height;
    return UIDeviceOrientationIsPortrait(self.currentDevice.orientation);
}

+ (BOOL)isLandscape {
    return !self.isPortrait;
}

+ (BOOL)iPhone {
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;
}

+ (BOOL)iPad {
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
}

+ (BOOL)isWideScreen {
    return self.isIOS8 ? self.isWideScreenIOS8 : self.isWideScreenIOS7;
}

+ (BOOL)isWideScreenIOS7 {
    return fabs((double) UIScreen.mainScreen.bounds.size.height - (double) 568) < DBL_EPSILON;
}

+ (BOOL)isWideScreenIOS8 {
    return fabs((double) UIScreen.mainScreen.nativeBounds.size.height - (double) 1136) < DBL_EPSILON;
}

+ (float)systemVersion {
    return self.currentDevice.systemVersion.floatValue;
}

+ (BOOL)isIOS8 {
    return self.systemVersion >= 8;
}

+ (BOOL)isIOS10 {
    return self.systemVersion >= 10;
}

+ (BOOL)isIOS11 {
    return self.systemVersion >= 11;
}

+ (BOOL)isIOS7 {
    return self.systemVersion >= 7 && self.systemVersion < 8;
}
@end