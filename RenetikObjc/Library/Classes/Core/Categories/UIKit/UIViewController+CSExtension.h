//
//  Created by Rene Dohan on 6/11/12.
//

@import UIKit;

@class MBProgressHUD;
@class CSResponse;

@interface UIViewController (CSExtension) <UITextFieldDelegate>

//- (UIViewController *)dismissChildController:(UIViewController *)controller;

//- (UIPopoverController *)presentModalFromView:(UIView *)view :(UIViewController *)controller :(id <UIPopoverControllerDelegate>)delegate;

//- (UIPopoverController *)presentModalFromBar:(UIBarButtonItem *)buttonItem :(UIViewController *)controller :(id <UIPopoverControllerDelegate>)delegate;

//- (UIPopoverController *)presentModalFrom:(id)sender :(UIViewController *)controller;

//- (UIViewController *)showChildControllerUnderLast:(UIViewController *)controller;
//
//- (UIViewController *)showChildControllerNextLast:(UIViewController *)controller :(UIView *)view;
//
//- (UIViewController *)showChildController:(UIViewController *)controller;
//
//- (UIViewController *)showChildController:(UIViewController *)controller :(UIView *)view;
//
//- (UIViewController *)addChildController:(UIViewController *)controller;

- (void)presentController:(UIViewController *)modalViewController;

- (void)dismissController;

- (instancetype)backButtonWithoutPreviousTitle;

- (instancetype)backButtonTitle:(NSString *)title;

- (BOOL)isControllerOnTop;

@end
