//
// Created by Rene Dohan on 25/02/18.
// Copyright (c) 2018 renetik_software. All rights reserved.
//

@import MBProgressHUD;

#import "UIView+CSMBProgressHUD.h"

#import "MBProgressHUD+CSExtension.h"
#import "CSLang.h"

@implementation UIView (CSMBProgressHUD)

- (MBProgressHUD*)showMessage:(NSString*)string {
    return [MBProgressHUD showMessage:self :string];
}

- (MBProgressHUD*)showProgress {
    MBProgressHUD*hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.animationType = MBProgressHUDAnimationZoom;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = UIColor.clearColor;
    return hud;
}

- (MBProgressHUD*)showProgress:(UIColor*)color {
    let progress = [MBProgressHUD showHUDAddedTo:self animated:YES];
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
