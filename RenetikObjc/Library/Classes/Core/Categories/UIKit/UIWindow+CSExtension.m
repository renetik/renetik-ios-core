//
// Created by Rene Dohan on 6/26/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "UIWindow+CSExtension.h"


@implementation UIWindow (CSExtension)

- (void)showRootController:(UIViewController *)controller {
    [UIView transitionWithView:self duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^(void) {
                        BOOL oldState = [UIView areAnimationsEnabled];
                        [UIView setAnimationsEnabled:NO];
                        self.rootViewController = controller;
                        [UIView setAnimationsEnabled:oldState];
                    } completion:nil];
}

@end