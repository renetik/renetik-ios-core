//
// Created by Rene Dohan on 25/1/17.
// Copyright (c) 2017 Renetik Software. All rights reserved.
//

#import "RMessage+CSExtension.h"

@implementation RMessage (CSExtension)

+ (void)showBottomMessage:(UIViewController *)controller
                    title:(NSString *)title
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

+ (void)showBottomError:(UIViewController *)controller
                  title:(NSString *)title :(NSString *)text
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

+ (void)showBottomSuccess:(UIViewController *)controller
                    title:(NSString *)title
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

+ (void)showBottomMessage:(UIViewController *)controller
                    title:(NSString *)title
                 duration:(NSTimeInterval)duration
              buttonTitle:(NSString *)buttonTitle
           buttonCallback:(void (^)())buttonCallback
                       at:(RMessagePosition)messagePosition
           canBeDismissed:(BOOL)dismissingEnabled {
    [RMessage showNotificationInViewController:controller
                                         title:title
                                      subtitle:nil
                                     iconImage:nil
                                          type:RMessageTypeSuccess
                                customTypeName:nil
                                      duration:duration
                                      callback:nil
                                   buttonTitle:buttonTitle
                                buttonCallback:buttonCallback
                                    atPosition:messagePosition
                          canBeDismissedByUser:dismissingEnabled];
}

+ (void)showNotificationWithTitle:(NSString *)string {
    [RMessage showNotificationWithTitle:string type:RMessageTypeNormal customTypeName:nil callback:nil];
}

+ (void)showNotificationWithTitle:(NSString *)string type:(RMessageType)type {
    [RMessage showNotificationWithTitle:string type:type customTypeName:nil callback:nil];
}

+ (void)showNotificationWithTitle:(NSString *)title :(NSString *)subtitle type:(RMessageType)type {
    [RMessage showNotificationWithTitle:title subtitle:subtitle type:type customTypeName:nil callback:nil];
}
@end