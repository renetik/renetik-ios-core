//
// Created by Rene Dohan on 25/1/17.
// Copyright (c) 2017 Renetik Software. All rights reserved.
//

#import "RMessage+CSExtension.h"

@implementation RMessage (CSExtension)

+ (void)showBottomMessage:(UIViewController*)controller
    title:(NSString*)title
    duration:(NSTimeInterval)duration
    canBeDismissed:(BOOL)dismissingEnabled; {
    [RMessage showNotificationInViewController:controller
                                         title:title
                                      subtitle:nil
                                     iconImage:nil
                                          type:RMessageTypeNormal
                                customTypeName:nil
                                      duration:duration
                                      callback:nil
                                   buttonTitle:nil
                                buttonCallback:nil
                                    atPosition:RMessagePositionNavBarOverlay
                          canBeDismissedByUser:dismissingEnabled];
}

+ (void)showBottomError:(UIViewController*)controller
    title:(NSString*)title :(NSString*)text
    duration:(NSTimeInterval)duration
    canBeDismissed:(BOOL)dismissingEnabled; {
    [RMessage showNotificationInViewController:controller
                                         title:title
                                      subtitle:text
                                     iconImage:nil
                                          type:RMessageTypeError
                                customTypeName:nil
                                      duration:duration
                                      callback:nil
                                   buttonTitle:nil
                                buttonCallback:nil
                                    atPosition:RMessagePositionNavBarOverlay
                          canBeDismissedByUser:dismissingEnabled];
}

+ (void)showBottomSuccess:(UIViewController*)controller
    title:(NSString*)title
    duration:(NSTimeInterval)duration
    canBeDismissed:(BOOL)dismissingEnabled; {
    [RMessage showNotificationInViewController:controller
                                         title:title
                                      subtitle:nil
                                     iconImage:nil
                                          type:RMessageTypeSuccess
                                customTypeName:nil
                                      duration:duration
                                      callback:nil
                                   buttonTitle:nil
                                buttonCallback:nil
                                    atPosition:RMessagePositionNavBarOverlay
                          canBeDismissedByUser:dismissingEnabled];
}

+ (void)show:(UIViewController*)viewController
    title:(NSString*)title
    subtitle:(NSString*)subtitle
    type:(RMessageType)type
    duration:(NSTimeInterval)duration
    atPosition:(RMessagePosition)messagePosition
    canBeDismissedByUser:(BOOL)dismissingEnabled
    callback:(void (^)(void))callback {
    [RMessage showNotificationInViewController:viewController
                                         title:title
                                      subtitle:subtitle
                                     iconImage:nil
                                          type:type
                                customTypeName:nil
                                      duration:duration
                                      callback:callback
                                   buttonTitle:nil
                                buttonCallback:nil
                                    atPosition:messagePosition
                          canBeDismissedByUser:dismissingEnabled];
}

+ (void)showNotificationWithTitle:(NSString*)string {
    [RMessage showNotificationWithTitle:string type:RMessageTypeNormal customTypeName:nil callback:nil];
}

+ (void)showNotificationWithTitle:(NSString*)string type:(RMessageType)type {
    [RMessage showNotificationWithTitle:string type:type customTypeName:nil callback:nil];
}

+ (void)showNotificationWithTitle:(NSString*)title :(NSString*)subtitle type:(RMessageType)type {
    [RMessage showNotificationWithTitle:title subtitle:subtitle type:type customTypeName:nil callback:nil];
}

@end
