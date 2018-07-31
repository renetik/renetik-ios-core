//
// Created by Rene Dohan on 29/10/15.
// Copyright (c) 2015 creative_studio. All rights reserved.
//

@import BlocksKit;
#import "CSMainController.h"
#import "CSMenuItem.h"
#import "CSActionSheet.h"
#import "CSMenuHeader.h"
#import "CSMenuIcon.h"

@implementation CSMainController {
    NSMutableArray<CSMainController *> *_controllers;
    CSActionSheet *_menuSheet;
}

- (instancetype)construct {
    [super construct];
    _menu = NSMutableArray.new;
    _controllers = NSMutableArray.new;
    return self;
}

- (instancetype)construct:(CSMainController *)parent {
    [self construct];
    _parent = parent;
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.isMainController) [self updateBarItemsAndMenu:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.menuSheet) [self.menuSheet hide];
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound && self.isMainController)
        [self onViewDismissing];
}

- (void)onViewDismissing {
    [super onViewDismissing];
    for (CSMainController *controller in _controllers)
        [controller onViewDismissing];
}

- (BOOL)isMainController {
    return [self.parentViewController isKindOfClass:UINavigationController.class] || _parent == nil;
}

- (BOOL)isChildController {
    return !self.isMainController;
}

- (void)updateBarItemsAndMenu {
    [self updateBarItemsAndMenu:NO];
}

- (void)updateBarItemsAndMenu:(BOOL)animated {
    if (self.isChildController) {
        [_parent updateBarItemsAndMenu:animated];
        return;
    }
    NSMutableArray<CSMenuHeader *> *menu = NSMutableArray.new;
    [self onPrepareMenu:menu];
    NSArray<UIBarButtonItem *> *actionItems = [self createActionBarItems:menu];
    UIBarButtonItem *barMenuItem = [self onCreateMenu:menu];
    NSMutableArray<UIBarButtonItem *> *barItems = NSMutableArray.new;
    if (barMenuItem) [barItems add:barMenuItem];
    [barItems addArray:actionItems];
    [self onPrepareRightBarButtonItems:barItems];
    [self.navigationItem setRightBarButtonItems:barItems];
    [self.navigationItem setLeftBarButtonItem:self.onPrepareLeftBarItem animated:true];
}

- (NSArray<UIBarButtonItem *> *)createActionBarItems:(NSMutableArray<CSMenuHeader *> *)menu {
    NSMutableArray<UIBarButtonItem *> *array = NSMutableArray.new;
    if (menu.first && menu.first.isDisplayedAsItem) {
        [array add:menu.first.items.first.createBarButton];
        [menu removeObjectAtIndex:0];
    }
    if (menu.first && menu.first.isDisplayedAsItem) {
        [array add:menu.first.items.first.createBarButton];
        [menu removeObjectAtIndex:0];
    }
    if (menu.count == 1 && menu.first.isDisplayedAsItem) {
        [array add:menu.first.items.first.createBarButton];
        [menu removeObjectAtIndex:0];
    }
    return array.reverse;
}

- (CSActionSheet *)menuSheet {
    return _menuSheet ? _menuSheet : (_menuSheet = CSActionSheet.new.construct);
}

- (UIBarButtonItem *)onCreateMenu:(NSMutableArray<CSMenuHeader *> *)menu {
    if (menu.empty) return nil;
    self.menuSheet.clear;
    for (CSMenuHeader *menuHeader in menu) {
        CSMenuItem *item = menuHeader.items.first;
        [self.menuSheet addAction:item.title :^{item.action(item);}];
    }
    return [UIBarButtonItem.alloc bk_initWithImage:CSMenuIcon.image style:UIBarButtonItemStylePlain handler:^(id sender) {
        if (_menuSheet.visible)[_menuSheet hide];
        else [_menuSheet showFromBarItem:sender];
    }];
}

- (void)onPrepareRightBarButtonItems:(NSMutableArray<UIBarButtonItem *> *)array {
}

- (void)addChildViewController:(UIViewController *)childController {
    [super addChildViewController:childController];
    if ([childController isKindOfClass:CSMainController.class])
        [_controllers addObject:(CSMainController *) childController];
}

- (UIViewController *)removeController:(UIViewController *)controller {
    [super removeController:controller];
    if ([controller isKindOfClass:CSMainController.class])
        [_controllers remove:(CSMainController *) controller];
    return controller;
}

- (NSArray<CSMainController *> *)setControllers:(NSArray<CSMainController *> *)controllers {
    [_controllers removeAllObjects];
    [self addControllers:controllers];
    return controllers;
}

- (NSArray<CSMainController *> *)addControllers:(NSArray<CSMainController *> *)controllers {
    [_controllers addObjectsFromArray:controllers];
    return controllers;
}

- (void)onPrepareMenu:(NSMutableArray<CSMenuHeader *> *)menu {
    for (CSMenuHeader *menuHeader in _menu) if (menuHeader.visible) [menu add:menuHeader];
    for (CSMainController *controller in _controllers) if (controller.showing) [controller onPrepareMenu:menu];
}

- (UIBarButtonItem *)onPrepareLeftBarItem {
    for (CSMainController *controller in _controllers) if (controller.showing) return controller.onPrepareLeftBarItem;
    return nil;
}

- (instancetype)showIn:(CSMainController *)parent {
    CATransition *transition = CATransition.animation;
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromBottom;
    [self.view.layer addAnimation:transition forKey:nil];
    [parent addController:self];
    self.view.hide.show;
    self.showing = YES;
    return self;
}

- (void)hideIn:(UIViewController *)parent {
    CATransition *transition = CATransition.animation;
    transition.duration = 0.7;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    [self.view.layer addAnimation:transition forKey:nil];
    self.view.hide;
    self.showing = NO;
    doLater(0.7,^{[parent removeController:self];});
}

- (CSMenuHeader *)menuHeader:(NSString *)title {
    return [_menu add:[CSMenuHeader.new construct:self :_menu.count :title]];
}

- (CSMenuItem *)menuItemView:(UIView *)view {
    return [self.menuHeader itemView:view];
}

- (CSMenuHeader *)menuHeader {
    return [self menuHeader:@""];
}

- (CSMenuItem *)menuItem {
    return [self menuItem:@""];
}

- (CSMenuItem *)menuItem:(NSString *)title {
    return [self.menuHeader item:title];
}

- (CSMenuItem *)menuItem:(NSString *)title :(void (^)(CSMenuItem *))onClick {
    CSMenuItem *item = [self.menuHeader item:title :onClick];
    return item;
}

- (CSMenuItem *)menuItem:(NSString *)title :(NSString *)description :(void (^)(CSMenuItem *))onClick {
    CSMenuItem *item = [self.menuHeader item:title :onClick];
    item.subTitle = description;
    return item;
}

- (CSMenuItem *)menuItem:(NSString *)title type:(UIBarButtonSystemItem)item {
    return [self.menuHeader item:title type:item];
}

- (CSMenuItem *)menuItem:(NSString *)title image:(UIImage *)image {
    return [self.menuHeader item:title image:image];
}

- (CSMenuItem *)menuItem:(NSString *)title :(UIImage *)image :(NSString *)note :(void (^)(CSMenuItem *))onClick {
    return [[[self.menuHeader item:title image:image] note:note] setOnClick:onClick];
}

- (CSMenuItem *)menuItem:(NSString *)title type:(UIBarButtonSystemItem)type :(void (^)(CSMenuItem *))onClick {
    return [self.menuHeader item:title type:type :onClick];
}

- (CSMenuItem *)menuItem:(NSString *)title :(NSString *)description type:(UIBarButtonSystemItem)type :(void (^)(CSMenuItem *))onClick {
    CSMenuItem *item = [self.menuHeader item:title type:type :onClick];
    item.subTitle = description;
    return item;
}


@end