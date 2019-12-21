//
//  Created by Rene Dohan on 10/26/12.
//

#import "CSNavigationController.h"
#import "UINavigationController+CSExtension.h"
#import "UIView+CSExtension.h"
#import "UIApplication+CSExtension.h"
#import "NSObject+CSExtension.h"
#import "UIDevice+CSExtension.h"
#import "UIScreen+CSExtension.h"


@implementation CSNavigationController {
    CSForcedOrientation _forcedOrientation;
    UIDeviceOrientation _orientationToReturnToFromForcedOrientation;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _instance = self;
    [self.navigationBar onClick:^(UIView *view) {
        UIApplication.resignFirstResponder;
    }];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    _lastPopped = self.last;
    return [super popViewControllerAnimated:animated];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    _lastPopped = nil;
    [super pushViewController:viewController animated:animated];
}

- (void)pushAsRoot:(UIViewController *)newRoot {
    _lastPopped = nil;
    [super pushAsRoot:newRoot];
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated {
    return [super popToRootViewControllerAnimated:animated];
}

- (NSArray *)popToViewController:(UIViewController *)controller animated:(BOOL)animated {
    _lastPopped = controller;
    return [super popToViewController:controller animated:animated];
}

- (BOOL)shouldAutorotate {
    return self.viewControllers.lastObject.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if (_forcedOrientation != CSForcedOrientationNone) {
        if (_forcedOrientation == CSForcedOrientationPortrait)
            return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown;
        return UIInterfaceOrientationMaskLandscape;
    }
    return [self.viewControllers.lastObject supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [self.viewControllers.lastObject preferredInterfaceOrientationForPresentation];
}

- (void)forceOrientation:(CSForcedOrientation)forcedOrientation {
    _forcedOrientation = forcedOrientation;
    _orientationToReturnToFromForcedOrientation = (UIDeviceOrientation) UIScreen.orientation;
    if ((forcedOrientation == CSForcedOrientationPortrait || forcedOrientation == CSForcedOrientationNone)
            && UIScreen.isLandscape)
        UIDevice.orientation = UIDeviceOrientationPortrait;
    else if ((forcedOrientation == CSForcedOrientationLandscape || forcedOrientation == CSForcedOrientationNone)
            && UIScreen.isPortrait)
        UIDevice.orientation = UIDeviceOrientationLandscapeLeft;
    [self addNotificationObserver:@selector(onUIDeviceOrientationDidChangeNotification:)
                             name:UIDeviceOrientationDidChangeNotification];
}

- (void)onUIDeviceOrientationDidChangeNotification:(id)notification {
    _orientationToReturnToFromForcedOrientation = UIDevice.orientation;
}

- (void)cancelForcedOrientation {
    _forcedOrientation = CSForcedOrientationNone;
    [self removeNotificationObserver];
    UIDevice.orientation = _orientationToReturnToFromForcedOrientation;
}

@end
