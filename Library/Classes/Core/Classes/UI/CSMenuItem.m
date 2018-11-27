//
// Created by Rene Dohan on 26/10/15.
// Copyright (c) 2015 creative_studio. All rights reserved.
//

#import <BlocksKit/BlocksKit+UIKit.h>
#import "CSMenuItem.h"
#import "CSMainController.h"

@implementation CSMenuItem {
    BOOL _visible;
}


- (instancetype)construct:(CSMainController *)parent :(NSString *)title {
    self.construct;
    _closeMenu = YES;
    _controller = parent;
    _title = title;
    _visible = YES;
    return self;
}

- (instancetype)construct:(CSMainController *)parent item:(UIBarButtonSystemItem)item :(void (^)(CSMenuItem *))action {
    [self construct:parent :@""];
    self.systemItem = item;
    self.action = action;
    return self;
}

- (instancetype)construct:(CSMainController *)parent :(NSString *)title :(void (^)(CSMenuItem *))action {
    [self construct:parent :title];
    self.action = action;
    return self;
}

- (instancetype)onClick:(void (^)(CSMenuItem *))onClick {
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

- (BOOL)visible {
    if (_isVisible) return _isVisible(self);
    return _visible;
}

- (void)setHidden:(BOOL)hidden {
    self.visible = !hidden;
}

- (void)updateMenu {
    if ([_controller isKindOfClass:CSMainController.class]) [_controller updateBarItemsAndMenu];
    else if ([_controller.parentViewController isKindOfClass:CSMainController.class])
        [(CSMainController *) _controller.parentViewController updateBarItemsAndMenu];
    else
        NSLog(@"CSMainController not found");
}

- (void)setTitle:(NSString *)title {
    _title = title;
    [self updateMenu];
}

- (void)setSystemItem:(UIBarButtonSystemItem)systemItem {
    _systemItem = systemItem;
    [self updateMenu];
}

- (UIBarButtonItem *)createBarButton {
    if (self.systemItem) return [UIBarButtonItem.alloc bk_initWithBarButtonSystemItem:self.systemItem handler:self.createAction];
    else if (self.image) return [UIBarButtonItem.alloc bk_initWithImage:self.image style:(UIBarButtonItemStylePlain) handler:self.createAction];
    else return [UIBarButtonItem.alloc bk_initWithTitle:self.title style:(UIBarButtonItemStylePlain) handler:self.createAction];
}

- (void (^)(id))createAction {
    return ^(id sender) {
        invokeWith(self.action, self);
    };
}

- (instancetype)closeMenu:(BOOL)close {
    _closeMenu = close;
    return self;
}

- (void)setView:(UIView *)view {
    _view = view;
}

- (instancetype)note:(NSString *)string {
    _subTitle = string;
    return self;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    [self updateMenu];
}

@end