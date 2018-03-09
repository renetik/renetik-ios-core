//
// Created by Rene Dohan on 26/10/15.
// Copyright (c) 2015 creative_studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BlocksKit/BlocksKit+UIKit.h>
#import "CSMenuItem.h"
#import "CSMainController.h"
#import "CSCocoaLumberjack.h"


@implementation CSMenuItem

- (instancetype)construct:(CSMainController *)parent :(NSString *)title {
    [super construct];
    _controller = parent;
    _title = title;
    _visible = YES;
    return self;
}

- (instancetype)construct:(CSMainController *)parent item:(UIBarButtonSystemItem)item :(void (^)())action {
    [self construct:parent :@""];
    self.systemItem = item;
    self.action = action;
    return self;
}


- (instancetype)construct:(CSMainController *)parent :(NSString *)title :(void (^)())action {
    [self construct:parent :title];
    self.action = action;
    return self;
}

- (instancetype)setOnClick:(void (^)())onClick {
    self.action = onClick;
    return self;
}

- (void)hide {
    self.visible = NO;
}

- (void)show {
    self.visible = YES;
}

- (void)setVisible:(BOOL)visible {
    if (_visible == visible) return;
    _visible = visible;
    [self updateMenu];
}

- (void)setHidden:(BOOL)hidden {
    self.visible = !hidden;
}

- (void)updateMenu {
    if ([_controller isKindOfClass:CSMainController.class])
        [((CSMainController *) _controller) updateRightBarItemsAndMenu];
    else if ([_controller.parentViewController isKindOfClass:CSMainController.class])
        [((CSMainController *) _controller.parentViewController) updateRightBarItemsAndMenu];
    else
        warn(@"CSMainController not found");
}

- (void)setTitle:(NSString *)title {
    _title = title;
    [self updateMenu];
}

- (UIBarButtonItem *)createBarButton {
    if (self.systemItem) return [UIBarButtonItem.alloc bk_initWithBarButtonSystemItem:self.systemItem handler:self.createAction];
    else if (self.image) return [UIBarButtonItem.alloc bk_initWithImage:self.image style:(UIBarButtonItemStylePlain) handler:self.createAction];
    else return [UIBarButtonItem.alloc bk_initWithTitle:self.title style:(UIBarButtonItemStylePlain) handler:self.createAction];
}

- (void (^)(id))createAction {
    return ^(id sender) {
        invoke(self.action);
    };
}
@end