//
//  Created by Rene Dohan on 12/26/12.
//

#import <UIKit/UIKit.h>

@implementation UIDevice (CSExtension)

+ (BOOL)isPortrait {
    if (self.currentDevice.orientation == UIDeviceOrientationUnknown) return UIScreen.mainScreen.bounds.size.width < UIScreen.mainScreen.bounds.size.height;
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

+ (BOOL)isSlimScreen {
    return UIDevice.iPhone && UIDevice.isPortrait;
}

+ (BOOL)isWideScreen {
    return !UIDevice.isSlimScreen;
}

+ (float)systemVersion {
    return self.currentDevice.systemVersion.floatValue;
}

+ (BOOL)isIOS10 {
    return self.systemVersion >= 10;
}

+ (BOOL)isIOS11 {
    return self.systemVersion >= 11;
}

@end
