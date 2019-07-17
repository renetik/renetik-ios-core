//
//  Created by Rene Dohan on 12/26/12.
//

#import <UIKit/UIKit.h>
#import "UIScreen+CSExtension.h"
#import "CSLang.h"

@implementation UIDevice (CSExtension)

//+ (BOOL)isPortrait {
//    let orientation = self.currentDevice.orientation;
//    if(orientation != UIDeviceOrientationUnknown) return UIDeviceOrientationIsPortrait(orientation);
//    else return UIScreen.isPortrait;
//}
//
//+ (BOOL)isLandscape {
//    return !self.isPortrait;
//}

+ (BOOL)iPhone {
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;
}

+ (BOOL)iPad {
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
}

+ (BOOL)isSlimScreen {
    return UIDevice.iPhone && UIScreen.isPortrait;
}

+ (BOOL)isSlimScreeniPhone5 {
    return UIDevice.iPhone && UIScreen.isPortrait;
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
