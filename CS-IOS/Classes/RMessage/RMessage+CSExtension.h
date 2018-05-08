//
// Created by Rene Dohan on 25/1/17.
// Copyright (c) 2017 Renetik Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RMessage/RMessage-umbrella.h>

@interface RMessage (CSExtension)

+ (void)showBottomMessage:(UIViewController *)controller title:(NSString *)title duration:(NSTimeInterval)duration canBeDismissed:(BOOL)dismissingEnabled;

+ (void)showBottomSuccess:(UIViewController *)controller title:(NSString *)title duration:(NSTimeInterval)duration canBeDismissed:(BOOL)dismissingEnabled;

+ (void)showBottomMessage:(UIViewController *)controller title:(NSString *)title duration:(NSTimeInterval)duration buttonTitle:(NSString *)buttonTitle buttonCallback:(void (^)(void))buttonCallback at:(RMessagePosition)messagePosition canBeDismissed:(BOOL)dismissingEnabled;

+ (void)showNotificationWithTitle:(NSString *)string;

+ (void)showNotificationWithTitle:(NSString *)string type:(RMessageType)type;

+ (void)showNotificationWithTitle:(NSString *)title :(NSString *)subtitle type:(RMessageType)type;
@end