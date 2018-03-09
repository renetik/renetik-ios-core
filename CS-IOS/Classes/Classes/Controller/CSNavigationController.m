//
//  Created by Rene Dohan on 10/26/12.
//


#import "CSNavigationController.h"


@implementation CSNavigationController {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _instance = self;
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
    return [self.viewControllers.lastObject shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.viewControllers.lastObject supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [self.viewControllers.lastObject preferredInterfaceOrientationForPresentation];
}

@end