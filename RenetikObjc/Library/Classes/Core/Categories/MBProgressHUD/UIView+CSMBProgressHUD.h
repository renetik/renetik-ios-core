//
// Created by Rene Dohan on 25/02/18.
// Copyright (c) 2018 renetik_software. All rights reserved.
//

@import UIKit;
@import MBProgressHUD;

NS_ASSUME_NONNULL_BEGIN
@interface UIView (CSMBProgressHUD)
- (MBProgressHUD*)showMessage:(NSString*)string;
- (instancetype)hideProgress;
- (MBProgressHUD*)showProgress;
- (MBProgressHUD*)showProgress:(UIColor*)color;
@end
NS_ASSUME_NONNULL_END
