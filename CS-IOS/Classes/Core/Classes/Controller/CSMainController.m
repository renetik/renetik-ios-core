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
    BOOL _onViewWillAppearFirstTime;
    BOOL _onViewDidAppearFirstTime;
}

- (instancetype)construct:(CSMainController *)parent {
    [self construct];
    _parent = parent;
    return self;
}

- (instancetype)construct {
    [super construct];
    _menu = NSMutableArray.new;
    _showing = NO;
    _controllers = NSMutableArray.new;
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.isMainController) [self updateBarItemsAndMenu:NO];
    [self onViewWillAppear];
    if (!_onViewWillAppearFirstTime) {
        _onViewWillAppearFirstTime = YES;
        [self onViewWillAppearFirstTime];
    } else [self onViewWillAppearFromPresentedController];
}

- (void)onViewWillAppear {
}

- (void)onViewWillAppearFirstTime {
}

- (void)onViewWillAppearFromPresentedController {
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.appearing = YES;
    [self onViewDidAppear];
    if (!_onViewDidAppearFirstTime) {
        _onViewDidAppearFirstTime = YES;
        [self onViewDidAppearFirstTime];
    } else [self onViewDidAppearFromPresentedController];
}

- (void)onViewDidAppear {
}

- (void)onViewDidAppearFirstTime {
}

- (void)onViewDidAppearFromPresentedController {
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [coordinator animateAlongsideTransition:nil completion:^(id <UIViewControllerTransitionCoordinatorContext> context) {
        [self onViewWillTransitionToSizeCompletion:size :context];
    }];
}

- (void)onViewWillTransitionToSizeCompletion:(CGSize)size :(id <UIViewControllerTransitionCoordinatorContext>)context {

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.menuSheet) [self.menuSheet hide];
    [self viewWillDisappear];
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound && self.isMainController)
        [self onViewDismissing];
    else if (self.isMovingFromParentViewController)
        [self onViewDismissing];
}

- (void)viewWillDisappear {
}

- (void)onViewDismissing {
    [self removeNotificationObserver];
    for (CSMainController *controller in _controllers)
        [controller onViewDismissing];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.appearing = NO;
    [self viewDidDisappear];
}

- (void)viewDidDisappear {
}

- (void)setShowing:(BOOL)showing {
    _showing = showing;
    if (showing) [self onViewShowing];
}

- (void)onViewShowing {
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
    UIBarButtonItem *barMenuItem = [self onCreateMenu:menu];
    NSMutableArray<UIBarButtonItem *> *barItems = NSMutableArray.new;
    if (barMenuItem) [barItems add:barMenuItem];
    if (menu.second && menu.count == 2)[barItems add:menu.second.items.first.createBarButton];
    if (menu.first) [barItems add:menu.first.items.first.createBarButton];
    [self onPrepareRightBarButtonItems:barItems];
    [self.navigationItem setRightBarButtonItems:barItems];
    [self.navigationItem setLeftBarButtonItem:self.onPrepareLeftBarItem animated:true];
}

- (CSActionSheet *)menuSheet {
    return _menuSheet ? _menuSheet : (_menuSheet = CSActionSheet.new.construct);
}

- (UIBarButtonItem *)onCreateMenu:(NSMutableArray<CSMenuHeader *> *)menu {
    if (menu.count <= 2) return nil;
    self.menuSheet.clear;
    for (uint i = 1; i < menu.count; ++i) {
        CSMenuItem *item = menu[i].items.first;
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

- (void)showIn:(CSMainController *)parent {
    [parent addController:self];
    [self.view matchParent];
    [self.view hide];
    [self.view fadeIn];
    self.showing = YES;
}

- (void)hideIn:(UIViewController *)parent {
    [self.view fadeOut:CS_FADE_TIME :^{
        [parent removeController:self];
    }];
    self.showing = NO;
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

- (CSMenuItem *)menuItem:(NSString *)title {
    return [self.menuHeader item:title];
}

- (CSMenuItem *)menuItem:(NSString *)title :(void (^)(CSMenuItem *))onClick {
    return [self.menuHeader item:title :onClick];
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

- (CSMenuItem *)menuItem {
    return [self menuItem:@""];
}

- (BOOL)visible {
    return self.appearing && self.showing;
}


@end