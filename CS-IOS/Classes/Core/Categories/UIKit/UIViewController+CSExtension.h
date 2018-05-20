//
//  Created by Rene Dohan on 6/11/12.
//


#import <UIKit/UIKit.h>

@class MBProgressHUD;
@class CSResponse;

@interface UIViewController (CSExtension) <UITextFieldDelegate>

+ (instancetype)create;

+ (instancetype)create:(NSString *)nib;

- (UIPopoverController *)presentModalFromView:(UIView *)view :(UIViewController *)controller :(id <UIPopoverControllerDelegate>)delegate;

- (UIPopoverController *)presentModalFromBar:(UIBarButtonItem *)buttonItem :(UIViewController *)controller :(id <UIPopoverControllerDelegate>)delegate;

- (UIPopoverController *)presentModalFrom:(id)sender :(UIViewController *)controller;

- (UIViewController *)addControllerUnder:(UIViewController *)controller;

- (UIViewController *)addControllerNext:(UIViewController *)controller :(UIView *)view;

- (UIViewController *)addController:(UIViewController *)controller;

- (UIViewController *)addController:(UIViewController *)controller :(UIView *)view;

- (UIViewController *)addControllerWithoutView:(UIViewController *)controller;

- (void)presentViewController:(UIViewController *)modalViewController;

- (void)dismissViewController;

- (UIViewController *)removeController:(UIViewController *)controller;

- (NSString *)controllerName;

- (instancetype)backButtonWithoutPreviousTitle;

- (instancetype)backButtonTitle:(NSString *)title;

- (BOOL)isControllerOnTop;

@end