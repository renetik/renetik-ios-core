//
// Created by Rene Dohan on 02/12/14.
// Copyright (c) 2014 creative_studio. All rights reserved.
//

@import UIKit;
@import MBProgressHUD;

@interface MBProgressHUD (CSExtension)
+ (MBProgressHUD *)showMessage:(NSString *)message;

+ (MBProgressHUD *)showMessage:(UIView *)view :(NSString *)message;
@end