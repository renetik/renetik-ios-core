//
//  Created by Rene Dohan on 5/2/12.
//


#import <Foundation/Foundation.h>

@protocol CSImagePickerListener;

@interface CSImagePickerController : NSObject <UIPopoverControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property(nonatomic, strong) UIPopoverController *popover;

- (id)initWithButtons:(UIViewController <CSImagePickerListener> *)delegate;

- (void)showFromBarButton:(UIBarButtonItem *)sender;

- (void)showFromButton:(UIView *)sender;

- (void)hide;

@end