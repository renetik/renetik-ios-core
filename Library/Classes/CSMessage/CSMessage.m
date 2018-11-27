//
// Created by Rene Dohan on 24/07/18.
//


#import "CSMessage.h"

@interface CSMessage ()
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *subtitle;
@property(nonatomic) enum RMessagePosition position;
@property(nonatomic) BOOL dismissable;
@property(nonatomic) RMessageType type;
@property(nonatomic) NSTimeInterval duration;
@end

@implementation CSMessage

- (instancetype)init {
    if (self = super.init) {
        self.position = RMessagePositionTop;
        self.dismissable = YES;
        self.type = RMessageTypeSuccess;
        self.duration = RMessageDurationAutomatic;
    }
    return self;
}


- (instancetype)bottom {
    self.position = RMessagePositionBottom;
    return self;
}

- (instancetype)top {
    self.position = RMessagePositionTop;
    return self;
}

- (instancetype)type:(RMessageType) type {
    self.type = type;
    return self;
}

- (instancetype)navBar {
    self.position = RMessagePositionNavBarOverlay;
    return self;
}

- (instancetype)title:(NSString *)title {
    self.title = title;
    return self;
}

- (instancetype)title:(NSString *)title show:(UIViewController *)parent{
    self.title = title;
    [self show:parent];
    return self;
}

- (instancetype)subtitle:(NSString *)subtitle {
    self.subtitle = subtitle;
    return self;
}

- (instancetype)dismissable:(BOOL)dismissable {
    self.dismissable = dismissable;
    return self;
}

- (instancetype)hanging {
    self.dismissable = NO;
    self.duration = RMessageDurationEndless;
    return self;
}

- (instancetype)show:(UIViewController *)parent {
    [RMessage showNotificationInViewController:parent title:self.title subtitle:self.subtitle iconImage:nil
                                          type:self.type customTypeName:nil duration:self.duration callback:nil
                          presentingCompletion:nil dismissCompletion:nil buttonTitle:nil buttonCallback:nil
                                    atPosition:self.position canBeDismissedByUser:self.dismissable];
    return self;
}

- (instancetype)dismiss {
    [RMessage dismissActiveNotification];
    return self;
}

@end
