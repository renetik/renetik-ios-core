//
// Created by Rene Dohan on 25/02/18.
// Copyright (c) 2018 renetik_software. All rights reserved.
//

#import "UIView+CSMBProgressHUD.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+CSExtension.h"

@implementation UIView (CSMBProgressHUD)

- (MBProgressHUD *)showMessage:(NSString *)string {
    return [MBProgressHUD showMessage:self :string];
}

- (MBProgressHUD *)showProgress {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.animationType = MBProgressHUDAnimationZoom;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [UIColor clearColor];
    return hud;
}

- (instancetype)hideProgress {
    [MBProgressHUD hideHUDForView:self animated:YES];
    return self;
}

@end