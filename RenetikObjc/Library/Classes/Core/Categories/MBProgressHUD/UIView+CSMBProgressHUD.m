//
// Created by Rene Dohan on 25/02/18.
// Copyright (c) 2018 renetik_software. All rights reserved.
//

@import MBProgressHUD;

#import "UIView+CSMBProgressHUD.h"
#import "MBProgressHUD+CSExtension.h"
#import "CSLang.h"

@implementation UIView (CSMBProgressHUD)

//- (MBProgressHUD *)showMessage:(NSString *)string {
//    [MBProgressHUD hideHUDForView:self animated:true];
//    let message = [MBProgressHUD showMessage:self :string];
//    message.removeFromSuperViewOnHide = true;
//    return message;
//}
//
//- (MBProgressHUD *)showProgress {
//    [MBProgressHUD hideHUDForView:self animated:true];
//    let progress = [MBProgressHUD showHUDAddedTo:self animated:YES];
//    progress.removeFromSuperViewOnHide = true;
//    progress.animationType = MBProgressHUDAnimationZoom;
//    progress.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
//    progress.bezelView.backgroundColor = UIColor.clearColor;
//    return progress;
//}
//
- (MBProgressHUD *)showProgress:(UIColor *)color {
    [MBProgressHUD hideHUDForView:self animated:true];
    let progress = [MBProgressHUD showHUDAddedTo:self animated:YES];
    progress.removeFromSuperViewOnHide = true;
    progress.mode = MBProgressHUDModeIndeterminate;
    progress.activityIndicatorColor = color;
    progress.animationType = MBProgressHUDAnimationZoom;
    progress.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    progress.bezelView.backgroundColor = UIColor.clearColor;
    return progress;
}

- (instancetype)hideProgress {
    [MBProgressHUD hideHUDForView:self animated:YES];
    return self;
}

@end
