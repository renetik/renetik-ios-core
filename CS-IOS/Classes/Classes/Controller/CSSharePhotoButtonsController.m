//
//  Created by Rene Dohan on 5/2/12.
//
#import <UIKit/UIKit.h>
#import "NSObject+CSExtension.h"
#import "UIViewController+CSExtension.h"
#import "UINavigationController+CSExtension.h"

#import "CSSharePhotoButtonsController.h"
#import "CSActionSheet.h"
#import "CSSharePhotoButtonsListener.h"

@implementation CSSharePhotoButtonsController {
    CSActionSheet *_actionSheet;
    UIViewController <CSSharePhotoButtonsListener> *_parent;
}

- (id)initWithButtons:(UIViewController <CSSharePhotoButtonsListener> *)parentController {
    if (self = [super init]) _parent = parentController;
    return self;
}

- (void)showFromBarButton:(UIBarButtonItem *)buttonItem {
    if (_actionSheet.visible) {
        [_actionSheet hide];
        return;
    }
    [self createSheet:buttonItem];
    [_actionSheet showFromBarItem:buttonItem];
}

- (void)showFromButton:(UIView *)sender {
    if (_actionSheet.visible) {
        [_actionSheet hide];
        return;
    }
    [self createSheet:sender];
    [_actionSheet showFromRect:sender.bounds inView:sender.superview];
}

- (void)createSheet:(id)sender {
    _actionSheet = [CSActionSheet.new.construct actions:@[@"Choose Photo", @"Take Picture"] :@[^{
        [self onGalleryClick:sender];
    }, ^{
        [self onCaptureClick];
    }]];
}

- (void)onGalleryClick:(id)sender {
    _popover = nil;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *picker = [UIImagePickerController new];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        _popover = [_parent presentModalFrom:sender :picker];
    } else showMessage(@"Library not available");
}

- (void)onCaptureClick {
    _popover = nil;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [UIImagePickerController new];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [_parent presentViewController:picker];
    } else showMessage(@"Camera not available");
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)data {
    [self dismiss];
    [_parent imagePickerController:picker didFinishPickingMediaWithInfo:data];
}

- (void)dismiss {
    if (!_popover) [_parent dismissViewController];
    else [_popover dismissPopoverAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismiss];
}

- (void)hide {
    [_actionSheet hide];
}
@end
