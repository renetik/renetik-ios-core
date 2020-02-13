//
// Created by Rene Dohan on 02/12/14.
// Copyright (c) 2014 creative_studio. All rights reserved.
//

#import "MBProgressHUD+CSExtension.h"
#import "UIApplication+CSExtension.h"

@implementation MBProgressHUD (CSExtension)

//+ (MBProgressHUD *)showMessage:(NSString *)message {
//    return [MBProgressHUD showMessage:nil :message];
//}
//
//+ (MBProgressHUD *)showMessage:(UIView *)view :(NSString *)message {
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:(view ? view : UIApplication.window) animated:YES];
//    hud.mode = MBProgressHUDModeText;
//    hud.detailsLabel.text = message;
//    [hud hideAnimated:YES afterDelay:5];
//    [hud addGestureRecognizer:[UITapGestureRecognizer.alloc initWithTarget:hud action:@selector(onShowMessageTap:)]];
//    return hud;
//}
//
//- (void)onShowMessageTap:(UITapGestureRecognizer *)tapped {
//    [((MBProgressHUD *) tapped.view) hideAnimated:YES];
//}

@end