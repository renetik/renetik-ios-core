//
// Created by Rene Dohan on 17/11/16.
// Copyright (c) 2016 renetik_software. All rights reserved.
//

@import UIKit;

@class CSResponse;

NS_ASSUME_NONNULL_BEGIN

@protocol CSViewControllerProtocol <NSObject>

- (CSResponse *)showFailed:(CSResponse *)response;

- (UIViewController *)asController;

- (CSResponse *)showProgress:(CSResponse *)response;

- (void)showMessage:(NSString *)message onPositive:(nullable void (^)())onPositive
NS_SWIFT_NAME(show(message:onPositive:));

//- (void)showTitle:(NSString *)title message:(NSString *)message
//    positiveTitle:(NSString *)positiveTitle onPositive:(void (^)())onPositive
//    negativeTitle:(NSString *)negativeTitle
//NS_SWIFT_NAME(show(title:message:positiveTitle:onPositive:negativeTitle:));

@end

NS_ASSUME_NONNULL_END
