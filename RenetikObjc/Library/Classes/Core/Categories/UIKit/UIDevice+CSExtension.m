//
//  Created by Rene Dohan on 12/26/12.
//

@implementation UIDevice (CSExtension)

//+ (void)setOrientation:(UIDeviceOrientation)orientation {
//    [UIDevice.currentDevice setValue:@(orientation) forKey:@"orientation"];
//    [UIViewController attemptRotationToDeviceOrientation];
//    [UIDevice.currentDevice setValue:@(UIDeviceOrientationUnknown) forKey:@"orientation"];
//}
//
//+ (UIDeviceOrientation)orientation {
//    return UIDevice.currentDevice.orientation;
//}

+ (BOOL)iPhone {
    return self.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPhone;
}

+ (BOOL)iPad {
    return self.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad;
}
//
//+ (float)systemVersion {
//    return self.currentDevice.systemVersion.floatValue;
//}
//
//+ (BOOL)isIOS10 {
//    return self.systemVersion >= 10;
//}
//
//+ (BOOL)isIOS11 {
//    return self.systemVersion >= 11;
//}

@end
