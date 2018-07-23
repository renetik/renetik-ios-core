//
//  Created by Rene Dohan on 6/11/12.
//

#import "NSString+CSExtension.h"
#import "UINavigationController+CSExtension.h"

@implementation UIViewController (CSExtension)

- (NSString *)controllerName {
    return [[self.class description] replaceLast:@"Controller" :@""];
}

- (instancetype)backButtonWithoutPreviousTitle {
    self.navigationItem.backBarButtonItem = [UIBarButtonItem createWithTitle:@"" :(UIBarButtonItemStylePlain) :nil :nil];
    return self;
}

- (instancetype)backButtonTitle:(NSString *)title {
    self.navigationItem.backBarButtonItem.title = title;
    return self;
}

- (BOOL)isControllerOnTop {
    return self.navigationController.last == self;
}

- (UIPopoverController *)presentModalFromView:(UIView *)view :(UIViewController *)controller :(id <UIPopoverControllerDelegate>)delegate {
    if (UIDevice.iPad) {
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:controller];
        popover.delegate = delegate;
        [popover presentPopoverFromRect:view.bounds inView:view.superview permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        return popover;
    } else {
        [self presentViewController:controller];
        return nil;
    }
}

- (UIPopoverController *)presentModalFromBar:(UIBarButtonItem *)buttonItem :(UIViewController *)controller :(id <UIPopoverControllerDelegate>)delegate {
    if (UIDevice.iPad) {
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:controller];
        popover.delegate = delegate;
        [popover presentPopoverFromBarButtonItem:buttonItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        return popover;
    } else {
        [self presentViewController:controller];
        return nil;
    }
}

- (UIPopoverController *)presentModalFrom:(id)sender :(UIViewController *)controller {
    if (!sender) {
        [self presentViewController:controller];
        return nil;
    }
    if ([sender isKindOfClass:UIBarButtonItem.class]) return [self presentModalFromBar:sender :controller :nil];
    return [self presentModalFromView:sender :controller :nil];
}

+ (instancetype)create {
    NSString *className = NSStringFromClass(self.class);
//    NSString *viewName = [className stringByReplacingOccurrencesOfString:@"Controller" withString:@""];
    return [[self alloc] initWithNibName:className bundle:nil];
}

+ (instancetype)create:(NSString *)nib {
    return [[self alloc] initWithNibName:nib bundle:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}

- (UIViewController *)removeController:(UIViewController *)controller {
    [controller willMoveToParentViewController:nil];
    [controller.view removeFromSuperview];
    [controller removeFromParentViewController];
    return controller;
}

- (UIViewController *)addController:(UIViewController *)controller {
    return [self addController:controller :self.view];
}

- (UIViewController *)addControllerUnder:(UIViewController *)controller {
    [self.view positionUnderLast:controller.view];
    [self addController:controller :self.view];
    return controller;
}

- (UIViewController *)addControllerNext:(UIViewController *)controller :(UIView *)view {
    [self.view positionViewNextLast:controller.view];
    [self addController:controller :view];
    return controller;
}

- (UIViewController *)addController:(UIViewController *)controller :(UIView *)view {
    [self addChildViewController:controller];
    [view addSubview:controller.view];
    [controller didMoveToParentViewController:self];
    return controller;
}

- (UIViewController *)addControllerWithoutView:(UIViewController *)controller {
    [self addChildViewController:controller];
    [controller didMoveToParentViewController:self];
    return controller;
}

- (void)presentViewController:(UIViewController *)modalViewController {
    [self presentViewController:modalViewController animated:YES completion:nil];
}

- (void)dismissViewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
