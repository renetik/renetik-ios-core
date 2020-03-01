//
//  Created by Rene Dohan on 6/11/12.
//

@import UIKit;

@class MBProgressHUD;
@class CSResponse;

@interface UIViewController (CSExtension) <UITextFieldDelegate>

- (void)presentController:(UIViewController *)modalViewController;

- (void)dismissController;

- (instancetype)backButtonWithoutPreviousTitle;

- (instancetype)backButtonTitle:(NSString *)title;

- (BOOL)isControllerOnTop;

@end
