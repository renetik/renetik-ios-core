//
// Created by Rene Dohan on 25/02/18.
// Copyright (c) 2018 renetik_software. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MBProgressHUD;

@interface UIViewController (CSMBProgressHUD)
- (MBProgressHUD *)showProgress;

- (instancetype)hideProgress;
@end