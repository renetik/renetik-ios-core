//
//  Created by Rene Dohan on 5/2/12.
//
#import "CSImagePickerController.h"
#import "CSImagePickerListener.h"
#import "CSMainController.h"
#import "UIViewController+CSExtension.h"
#import "UINavigationController+CSExtension.h"
#import "CSViewControllerProtocol.h"
#import "CSActionSheet.h"
#import "CSLang.h"

@implementation CSImagePickerController {
    CSActionSheet *_actionSheet;
    UIViewController <CSViewControllerProtocol, CSImagePickerListener> *_parent;
}

- (instancetype)initWithParent:(UIViewController <CSImagePickerListener, CSViewControllerProtocol> *)parent {
    if (self = super.init) _parent = parent;
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
    [_actionSheet showFromRect:sender.frame inView:sender.superview];
}

- (void)createSheet:(id)sender {
    _actionSheet = [CSActionSheet.new actions:@[@"Choose Photo", @"Take Picture"] :@[^{
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
    } else [_parent showMessage:@"Gallery not available" onPositive:nil];
}

- (void)onCaptureClick {
    _popover = nil;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [UIImagePickerController new];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [_parent presentController:picker];
    } else [_parent showMessage:@"Camera not available" onPositive:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)data {
    [self dismiss];
    [_parent imagePickerController:picker didFinishPickingMediaWithInfo:data];
}

- (void)dismiss {
    if (!_popover) [_parent dismissController];
    else [_popover dismissPopoverAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismiss];
}

- (void)hide {
    [_actionSheet hide];
}
@end
