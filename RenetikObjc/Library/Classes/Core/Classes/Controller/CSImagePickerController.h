//
//  Created by Rene Dohan on 5/2/12.
//


@import UIKit;

@protocol CSImagePickerListener;
@protocol CSViewControllerProtocol;

@class CSMainController;

@interface CSImagePickerController : NSObject <UIPopoverControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property(nonatomic, strong) UIPopoverController *popover;

- (instancetype)initWithParent:(UIViewController <CSImagePickerListener, CSViewControllerProtocol> *)parent;

- (void)showFromBarButton:(UIBarButtonItem *)sender;

- (void)showFromButton:(UIView *)sender;

- (void)hide;

@end