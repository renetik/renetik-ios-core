//
// Created by Rene Dohan on 25/02/18.
// Copyright (c) 2018 renetik_software. All rights reserved.
//

@import UIKit;
@import MBProgressHUD;

@interface UIView (CSMBProgressHUD)
- (MBProgressHUD *)showMessage:(NSString *)string;

- (MBProgressHUD *)showProgress;

- (instancetype)hideProgress;
@end