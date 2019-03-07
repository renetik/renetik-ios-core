//
// Created by Rene Dohan on 29/10/15.
// Copyright (c) 2015 creative_studio. All rights reserved.
//

@import UIKit;
@import BlocksKit;

#import "CSMainController.h"
#import "CSActionSheet.h"
#import "NSArray+CSExtension.h"
#import "NSMutableArray+CSExtension.h"
#import "UIViewController+CSExtension.h"
#import "CSMenuHeader.h"
#import "CSMenuItem.h"
#import "CSMenuIcon.h"
#import "UIView+CSExtension.h"
#import "CSLang.h"

@implementation CSMainController {
    NSMutableArray<CSMainController *> *_childMainControllers;
    CSActionSheet *_menuSheet;
}

- (instancetype)init {
    if (self == super.init) {
        _menu = NSMutableArray.new;
        _childMainControllers = NSMutableArray.new;
    }
    return self;
}

- (void)viewWillAppear :(BOOL)animated {
    [super viewWillAppear :animated];
    if (self.isMainController) [self updateBarItemsAndMenu :NO];
}

- (void)viewDidAppear :(BOOL)animated {
    [super viewDidAppear :animated];
}

- (void)viewWillDisappear :(BOOL)animated {
    [super viewWillDisappear :animated];
    if (self.menuSheet) [self.menuSheet hide];
    if ([self.navigationController.viewControllers indexOfObject :self] == NSNotFound && self.isMainController) [self onViewDismissing];
}

- (void)onViewDismissing {
    [super onViewDismissing];
    for (CSMainController *controller in _childMainControllers)
        [controller onViewDismissing];
}

- (BOOL)isMainController {
    return [self.parentViewController isKindOfClass :UINavigationController.class] || _parent == nil;
}

- (BOOL)isChildController {
    return !self.isMainController;
}

- (void)updateBarItemsAndMenu {
    [self updateBarItemsAndMenu :NO];
}

- (void)updateBarItemsAndMenu :(BOOL)animated {
    if (self.isChildController) {
        [_parent updateBarItemsAndMenu :animated];
        return;
    }
    NSMutableArray<CSMenuHeader *> *menu = NSMutableArray.new;
    [self onPrepareMenu :menu];
    NSArray<UIBarButtonItem *> *actionItems = [self createActionBarItems :menu];
    UIBarButtonItem *barMenuItem = [self onCreateMenu :menu];
    NSMutableArray<UIBarButtonItem *> *barItems = NSMutableArray.new;
    if (barMenuItem) [barItems add :barMenuItem];
    [barItems addArray :actionItems];
    [self onPrepareRightBarButtonItems :barItems];
    [self.navigationItem setRightBarButtonItems :barItems];
    [self.navigationItem setLeftBarButtonItem :self.onPrepareLeftBarItem animated :true];
}

- (NSArray<UIBarButtonItem *> *)createActionBarItems :(NSMutableArray<CSMenuHeader *> *)menu {
    NSMutableArray<UIBarButtonItem *> *array = NSMutableArray.new;
    if (menu.first && menu.first.isDisplayedAsItem) {
        [array add :menu.first.items.first.createBarButton];
        [menu removeObjectAtIndex :0];
    }
    if (menu.first && menu.first.isDisplayedAsItem) {
        [array add :menu.first.items.first.createBarButton];
        [menu removeObjectAtIndex :0];
    }
    if (menu.count == 1 && menu.first.isDisplayedAsItem) {
        [array add :menu.first.items.first.createBarButton];
        [menu removeObjectAtIndex :0];
    }
    return array.reverse;
}

- (CSActionSheet *)menuSheet {
    return _menuSheet ? _menuSheet : (_menuSheet = CSActionSheet.new);
}

- (UIBarButtonItem *)onCreateMenu :(NSMutableArray<CSMenuHeader *> *)menu {
    if (menu.empty) return nil;
    self.menuSheet.clear;
    for (CSMenuHeader *menuHeader in menu) {
        CSMenuItem *item = menuHeader.items.first;
        [self.menuSheet addAction :item.title :^{
            item.action(item);
        }];
    }
    return [UIBarButtonItem.alloc bk_initWithImage :CSMenuIcon.image style :UIBarButtonItemStylePlain handler :^(id sender) {
        if (_menuSheet.visible) [_menuSheet hide];
        else [_menuSheet showFromBarItem :sender];
    }];
}

- (void)onPrepareRightBarButtonItems :(NSMutableArray<UIBarButtonItem *> *)array {
}

- (void)addChildViewController :(UIViewController *)childController {
    [super addChildViewController :childController];
    if ([childController isKindOfClass :CSMainController.class])
		[self addChildMainController :(CSMainController *)childController];
}

- (void)addChildMainController :(CSMainController *)childController {
    [_childMainControllers add :childController];
    childController.parent = self;
}

- (UIViewController *)dismissChildController :(UIViewController *)controller {
    [super dismissChildController :controller];
    if ([controller isKindOfClass :CSMainController.class]) [_childMainControllers remove :controller];
    return controller;
}

- (NSArray<CSMainController *> *)setChildMainControllers :(NSArray<CSMainController *> *)controllers {
    [_childMainControllers removeAllObjects];
    [self addChildMainControllers :controllers];
    return controllers;
}

- (NSArray<CSMainController *> *)addChildMainControllers :(NSArray<CSMainController *> *)controllers {
    for (CSMainController *controller in controllers) [self addChildMainController :controller];
    return controllers;
}

- (void)onPrepareMenu :(NSMutableArray<CSMenuHeader *> *)menu {
    for (CSMenuHeader *menuHeader in _menu) if (menuHeader.visible) [menu add :menuHeader];
    for (CSMainController *controller in _childMainControllers) if (controller.showing) [controller onPrepareMenu :menu];
}

- (UIBarButtonItem *)onPrepareLeftBarItem {
    for (CSMainController *controller in _childMainControllers) if (controller.showing) return controller.onPrepareLeftBarItem;
    return nil;
}

- (instancetype)showIn :(CSMainController *)parent {
    CATransition *transition = CATransition.animation;
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName :kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromBottom;
    [self.view.layer addAnimation :transition forKey :nil];
    [parent showChildController :self];
    self.showing = YES;
    return self;
}

- (void)hideIn :(UIViewController *)parent {
    CATransition *transition = CATransition.animation;
    transition.duration = 0.7;
    transition.timingFunction = [CAMediaTimingFunction functionWithName :kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    [self.view.layer addAnimation :transition forKey :nil];
    self.view.hide;
    self.showing = NO;
    doLater(0.7, ^{
        [parent dismissChildController :self];
    });
}

- (CSMenuHeader *)menuHeader :(NSString *)title {
    return [_menu add :[CSMenuHeader.new construct :self :_menu.count :title]];
}

- (CSMenuItem *)menuItemView :(UIView *)view {
    return [self.menuHeader itemView :view];
}

- (CSMenuHeader *)menuHeader {
    return [self menuHeader :@""];
}

- (CSMenuItem *)menuItem {
    return [self menuItem :@""];
}

- (CSMenuItem *)menuItem :(NSString *)title {
    return [self.menuHeader item :title];
}

- (CSMenuItem *)menuItem :(NSString *)title :(void (^)(CSMenuItem *))onClick {
    CSMenuItem *item = [self.menuHeader item :title :onClick];
    return item;
}

- (CSMenuItem *)menuItem :(NSString *)title :(NSString *)description :(void (^)(CSMenuItem *))onClick {
    CSMenuItem *item = [self.menuHeader item :title :onClick];
    item.subTitle = description;
    return item;
}

- (CSMenuItem *)menuItem :(NSString *)title type :(UIBarButtonSystemItem)item {
    return [self.menuHeader item :title type :item];
}

- (CSMenuItem *)menuItem :(NSString *)title image :(UIImage *)image {
    return [self.menuHeader item :title image :image];
}

- (CSMenuItem *)menuItemImage :(UIImage *)image {
    return [self menuItem :@"" image :image];
}

- (CSMenuItem *)menuItem :(NSString *)title :(UIImage *)image :(NSString *)note :(void (^)(CSMenuItem *))onClick {
    return [[[self.menuHeader item :title image :image] note :note] onClick :onClick];
}

- (CSMenuItem *)menuItem :(NSString *)title type :(UIBarButtonSystemItem)type :(void (^)(CSMenuItem *))onClick {
    return [self.menuHeader item :title type :type :onClick];
}

- (CSMenuItem *)menuItem :(NSString *)title :(NSString *)description type :(UIBarButtonSystemItem)type :(void (^)(CSMenuItem *))onClick {
    CSMenuItem *item = [self.menuHeader item :title type :type :onClick];
    item.subTitle = description;
    return item;
}

@end
