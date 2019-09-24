//
//  Created by Rene Dohan on 12/26/12.
//

#import <UIKit/UIKit.h>
#import "UIScreen+CSExtension.h"
#import "CSLang.h"

@implementation UIDevice (CSExtension)

+ (void)setOrientation:(UIDeviceOrientation)orientation {
    [UIDevice.currentDevice setValue:@(orientation) forKey:@"orientation"];
    [UIViewController attemptRotationToDeviceOrientation];
    [UIDevice.currentDevice setValue:@(UIDeviceOrientationUnknown) forKey:@"orientation"];
}

+ (UIDeviceOrientation)orientation {
    return UIDevice.currentDevice.orientation;
}

+ (BOOL)iPhone {
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;
}

+ (BOOL)iPad {
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
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
