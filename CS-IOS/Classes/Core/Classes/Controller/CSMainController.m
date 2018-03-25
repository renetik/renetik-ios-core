//
// Created by Rene Dohan on 29/10/15.
// Copyright (c) 2015 creative_studio. All rights reserved.
//

#import <MMDrawerController/MMDrawerBarButtonItem.h>
#import "CSMainController.h"
#import "CSMenuItem.h"
#import "CSActionSheet.h"
#import "CSMenuHeader.h"

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
    _customMenu = NSMutableArray.new;
    _showing = NO;
    _controllers = NSMutableArray.new;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.isMainController) {
        [self updateLeftBarItem];
        [self updateRightBarItemsAndMenu:NO];
    }
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

- (CSActionSheet *)menuSheet {
    if (self.isMainController && !_menuSheet) _menuSheet = CSActionSheet.new.construct;
    return _menuSheet;
}

- (void)updateRightBarItemsAndMenu {
    [self updateRightBarItemsAndMenu:NO];
}

- (void)updateRightBarItemsAndMenu:(BOOL)animated {
    if (self.isChildController) {
        [_parent updateRightBarItemsAndMenu:animated];
        return;
    }
    NSMutableArray<CSMenuItem *> *menuItems = NSMutableArray.new;
    [self onPrepareMenu:menuItems];
    NSMutableArray<UIBarButtonItem *> *items = NSMutableArray.new;
    self.menuSheet.clear;
    if (menuItems.count > 2) {
        [items add:[MMDrawerBarButtonItem.alloc initWithTarget:self action:@selector(onMenuClick:)]];
        for (int i = 1; i < menuItems.count; ++i) [self.menuSheet addAction:menuItems[i].title :menuItems[i].action];
    }
    if (menuItems.second && menuItems.count == 2)[items add:menuItems.second.createBarButton];
    if (menuItems.first) [items add:menuItems.first.createBarButton];
    [self onPrepareRightBarButtonItems:items];
    [self.navigationItem setRightBarButtonItems:items];

    [self.navigationItem setLeftBarButtonItem:self.onPrepareLeftBarItem animated:true];
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

- (void)onPrepareMenu:(NSMutableArray<CSMenuItem *> *)items {
    for (CSMenuItem *item in _menu) if (item.visible) [items add:item];
    for (CSMainController *controller in _controllers) if (controller.showing) [controller onPrepareMenu:items];
}

- (UIBarButtonItem *)onPrepareLeftBarItem {
    for (CSMainController *controller in _controllers) if (controller.showing) return controller.onPrepareLeftBarItem;
    return nil;
}

- (void)onMenuClick:(id)sender {
    if (self.menuSheet.visible)[self.menuSheet hide];
    else [self.menuSheet showFromBarItem:sender];
}

- (void)updateLeftBarItem {
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

- (CSMenuHeader *)addMenuHeader:(NSString *)title {
    return [_customMenu add:[CSMenuHeader.new construct:self :_menu.count :title]];
}

- (CSMenuItem *)addMenuItem:(NSString *)title {
    return [_menu add:[CSMenuItem.new construct:self :title]];
}

- (CSMenuItem *)addMenuItem:(NSString *)title :(void (^)())onClick {
    return [_menu add:[CSMenuItem.new construct:self :title :onClick]];
}

- (CSMenuItem *)addSystemMenuItem:(UIBarButtonSystemItem)item :(NSString *)title {
    CSMenuItem *menuItem = [_menu add:[CSMenuItem.new construct:(self) :title]];
    menuItem.systemItem = item;
    return menuItem;
}

- (CSMenuItem *)addImageMenuItem:(UIImage *)image :(NSString *)title {
    CSMenuItem *menuItem = [_menu add:[CSMenuItem.new construct:(self) :title]];
    menuItem.image = image;
    return menuItem;
}

- (CSMenuItem *)addSystemMenuItem:(UIBarButtonSystemItem)item :(NSString *)title :(void (^)())onClick {
    CSMenuItem *menuItem = [_menu add:[CSMenuItem.new construct:(self) :title :onClick]];
    menuItem.systemItem = item;
    return menuItem;
}

- (CSMenuItem *)addMenuItem {
    return [_menu add:[CSMenuItem.new construct:self :@""]];
}

- (BOOL)visible {
    return self.appearing && self.showing;
}


@end