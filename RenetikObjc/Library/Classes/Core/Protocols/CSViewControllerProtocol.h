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

//- (void)showMessage:(NSString *)message
//NS_SWIFT_NAME(show(message:));
//
//- (void)showMessage:(NSString *)message onPositive:(void (^)())onPositive
//NS_SWIFT_NAME(show(message:onPositive:));
//
//- (void)showMessage:(NSString *)message
//      positiveTitle:(NSString *)positiveTitle onPositive:(void (^)())onPositive
//NS_SWIFT_NAME(show(message:positiveTitle:onPositive:));
//
//- (void)showMessage:(NSString *)message
//      positiveTitle:(NSString *)positiveTitle onPositive:(void (^)())onPositive
//NS_SWIFT_NAME(show(message:positiveTitle:onPositive:));


//}
//
//@objc func show(title: String = TextTitle.applicationName,
//        message: String,
//_ negative: String = TextTitle.close,
//        _ positive: String = TextTitle.ok,
//        _ onPositive: @escaping (() -> Void)) {
//    let alert = SCLAlertView.create()
//    alert.addPrimaryButton(positive, onPositive)
//    alert.showTitle(title, subTitle: message, style: .notice,
//            closeButtonTitle: negative,
//            circleIconImage: StyleIcon.motoIconDark,
//            animationStyle: .topToBottom)
//}

@end

NS_ASSUME_NONNULL_END
