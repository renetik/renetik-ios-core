//
// Created by Rene Dohan on 25/02/18.
// Copyright (c) 2018 renetik_software. All rights reserved.
//

#import "UIViewController+CSMBProgressHUD.h"
#import "UIView+CSMBProgressHUD.h"
#import "MBProgressHUD.h"

@implementation UIViewController (CSMBProgressHUD)

- (MBProgressHUD *)showProgress {
    return self.view.showProgress;
}

- (instancetype)hideProgress {
    self.view.hideProgress;
    return self;
}

@end