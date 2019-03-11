//
//  Created by Rene Dohan on 6/11/12.
//
#import "NSString+CSExtension.h"
#import "UINavigationController+CSExtension.h"
#import "CSMainController.h"
#import "UIBarButtonItem+CSExtension.h"
#import "UIDevice+CSExtension.h"
#import "UIView+CSExtension.h"

@implementation UIViewController (CSExtension)

- (instancetype)construct {
	self.view.construct;
    return self;
}

- (instancetype)backButtonWithoutPreviousTitle {
    self.navigationItem.backBarButtonItem = [UIBarButtonItem createWithTitle :@"" :(UIBarButtonItemStylePlain) :nil :nil];
    return self;
}

- (instancetype)backButtonTitle :(NSString *)title {
    self.navigationItem.backBarButtonItem.title = title;
    return self;
}

- (BOOL)isControllerOnTop {
    return self.navigationController.last == self;
}

- (UIPopoverController *)presentModalFromView :(UIView *)view :(UIViewController *)controller :(id <UIPopoverControllerDelegate>)delegate {
    if (UIDevice.iPad) {
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController :controller];
        popover.delegate = delegate;
        [popover presentPopoverFromRect :view.bounds inView :view.superview permittedArrowDirections :UIPopoverArrowDirectionAny animated :YES];
        return popover;
    } else {
        [self presentController :controller];
        return nil;
    }
}

- (UIPopoverController *)presentModalFromBar :(UIBarButtonItem *)buttonItem :(UIViewController *)controller :(id <UIPopoverControllerDelegate>)delegate {
    if (UIDevice.iPad) {
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController :controller];
        popover.delegate = delegate;
        [popover presentPopoverFromBarButtonItem :buttonItem permittedArrowDirections :UIPopoverArrowDirectionAny animated :YES];
        return popover;
    } else {
        [self presentController :controller];
        return nil;
    }
}

- (UIPopoverController *)presentModalFrom :(id)sender :(UIViewController *)controller {
    if (!sender) {
        [self presentController :controller];
        return nil;
    }
    if ([sender isKindOfClass :UIBarButtonItem.class]) return [self presentModalFromBar :sender :controller :nil];
    return [self presentModalFromView :sender :controller :nil];
}

- (BOOL)textFieldShouldReturn :(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}

- (UIViewController *)showChildController :(UIViewController *)controller {
    return [self showChildController :controller :self.view];
}

- (UIViewController *)showChildControllerUnderLast :(UIViewController *)controller {
    [self.view positionUnderLast :controller.view];
    [self showChildController :controller :self.view];
    return controller;
}

- (UIViewController *)showChildControllerNextLast :(UIViewController *)controller :(UIView *)view {
    [self.view positionViewNextLast :controller.view];
    [self showChildController :controller :view];
    return controller;
}

- (UIViewController *)showChildController :(UIViewController *)controller :(UIView *)view {
    [self addChildViewController :controller];
    [view addSubview :controller.view];
    [controller didMoveToParentViewController :self];
    return controller;
}

- (UIViewController *)addChildController :(UIViewController *)controller {
    return [self showChildController :controller :nil];
}

- (UIViewController *)dismissChildController :(UIViewController *)controller {
    [controller willMoveToParentViewController :nil];
    [controller.view removeFromSuperview];
    [controller removeFromParentViewController];
    return controller;
}

- (void)presentController :(UIViewController *)modalViewController {
    [self presentViewController :modalViewController animated :YES completion :nil];
}

- (void)dismissController {
    [self dismissViewControllerAnimated :YES completion :nil];
}

@end
