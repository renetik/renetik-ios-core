//
// Created by Rene Dohan on 25/1/17.
// Copyright (c) 2017 Renetik Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RMessage/RMessage-umbrella.h>

@interface RMessage (CSExtension)

+ (void)showBottomMessage:(UIViewController*)controller title:(NSString*)title duration:(NSTimeInterval)duration canBeDismissed:(BOOL)dismissingEnabled;

+ (void)showBottomSuccess:(UIViewController*)controller title:(NSString*)title duration:(NSTimeInterval)duration canBeDismissed:(BOOL)dismissingEnabled;

+ (void)show:(UIViewController*)viewController
    title:(NSString*)title
    subtitle:(NSString*)subtitle
    type:(RMessageType)type
    duration:(NSTimeInterval)duration
    atPosition:(RMessagePosition)messagePosition
    canBeDismissedByUser:(BOOL)dismissingEnabled
    callback:(void (^)(void))callback;

+ (void)showNotificationWithTitle:(NSString*)string;

+ (void)showNotificationWithTitle:(NSString*)string type:(RMessageType)type;

+ (void)showNotificationWithTitle:(NSString*)title :(NSString*)subtitle type:(RMessageType)type;
@end
