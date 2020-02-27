//
//  Created by Rene Dohan on 6/11/12.
//
#import "UINavigationController+CSExtension.h"
#import "UIBarButtonItem+CSExtension.h"

@implementation UIViewController (CSExtension)

- (instancetype)backButtonWithoutPreviousTitle {
    self.navigationItem.backBarButtonItem =
            [UIBarButtonItem createWithTitle:@"" :UIBarButtonItemStylePlain :nil :nil];
    return self;
}

- (instancetype)backButtonTitle:(NSString *)title {
    self.navigationItem.backBarButtonItem.title = title;
    return self;
}

- (BOOL)isControllerOnTop {
    return self.navigationController.last == self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}

- (void)presentController:(UIViewController *)modalViewController {
    [self presentViewController:modalViewController animated:YES completion:nil];
}

- (void)dismissController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
