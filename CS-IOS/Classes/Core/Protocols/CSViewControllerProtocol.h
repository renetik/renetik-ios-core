//
// Created by Rene Dohan on 17/11/16.
// Copyright (c) 2016 renetik_software. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CSResponse;
@class CSAlertView;
@class CSActionSheet;
@class CSViewController;

@protocol CSViewControllerProtocol <NSObject>

- (CSResponse *)showFailed:(CSResponse *)response;

- (CSAlertView *)alert;

- (CSActionSheet *)sheet;

- (UIViewController *)asController;

- (CSResponse *)showProgress:(CSResponse *)response;

@end