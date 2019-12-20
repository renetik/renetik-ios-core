////
//// Created by Rene Dohan on 29/10/15.
//// Copyright (c) 2015 creative_studio. All rights reserved.
////
//
//@import UIKit;
//@import BlocksKit;
//
//#import "CSMainController.h"
//#import "CSActionSheet.h"
//#import "NSArray+CSExtension.h"
//#import "NSMutableArray+CSExtension.h"
//#import "UIViewController+CSExtension.h"
//#import "CSMenuHeader.h"
//#import "CSMenuItem.h"
//#import "CSMenuIcon.h"
//#import "UIView+CSExtension.h"
//#import "CSLang.h"
//#import "UIView+CSPosition.h"
//
//@implementation CSMainController {
//    NSMutableArray<CSMainController *> *_childMainControllers;
//    CSActionSheet *_menuSheet;
//}
//
//- (instancetype)constructAsViewLessIn:(UIViewController *)parent {
//    invoke(^{[parent showChildController:self];});
//    self.showing = YES;
//    return self;
//}
//
//- (instancetype)init {
//    if (self == super.init) {
//        _menu = NSMutableArray.new;
//        _childMainControllers = NSMutableArray.new;
//    }
//    return self;
//}
//
//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    if (self.isMainController) [self updateBarItemsAndMenu:NO];
//}
//
//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    if (_menuSheet) _menuSheet.hide;
//}
//
//- (BOOL)isMainController {
//    return [self.parentViewController isKindOfClass:UINavigationController.class] || _parentMain == nil;
//}
//
//- (BOOL)isChildController {
//    return !self.isMainController;
//}
//
//- (void)updateBarItemsAndMenu {
//    [self updateBarItemsAndMenu:NO];
//}
//
//- (void)updateBarItemsAndMenu:(BOOL)animated {
//    if (self.isChildController) {
//        [_parentMain updateBarItemsAndMenu:animated];
//        return;
//    }
//    NSMutableArray<CSMenuHeader *> *menu = NSMutableArray.new;
//    [self onPrepareMenu:menu];
//    NSArray<UIBarButtonItem *> *actionItems =
//            [self createActionBarItems:menu];
//    UIBarButtonItem *barMenuItem = [self onCreateMenu:menu];
//    NSMutableArray<UIBarButtonItem *> *barItems = NSMutableArray.new;
//    if (barMenuItem) [barItems put:barMenuItem];
//    [barItems addArray:actionItems];
//    [self onPrepareRightBarButtonItems:barItems];
//    [self.navigationItem setRightBarButtonItems:barItems];
//    [self.navigationItem setLeftBarButtonItem:self.onPrepareLeftBarItem animated:true];
//}
//
//- (NSArray<UIBarButtonItem *> *)createActionBarItems
//        :(NSMutableArray<CSMenuHeader *> *)menu {
//    NSMutableArray<UIBarButtonItem *> *array = NSMutableArray.new;
//    if (menu.first && menu.first.isDisplayedAsItem) {
//        [array put:menu.first.items.first.createBarButton];
//        [menu removeObjectAtIndex:0];
//    }
//    if (menu.first && menu.first.isDisplayedAsItem) {
//        [array put:menu.first.items.first.createBarButton];
//        [menu removeObjectAtIndex:0];
//    }
//    if (menu.count == 1 && menu.first.isDisplayedAsItem) {
//        [array put:menu.first.items.first.createBarButton];
//        [menu removeObjectAtIndex:0];
//    }
//    return array.reverse;
//}
//
//- (CSActionSheet *)menuSheet {
//    return _menuSheet ? _menuSheet : (_menuSheet = CSActionSheet.new);
//}
//
//- (UIBarButtonItem *)onCreateMenu:(NSMutableArray<CSMenuHeader *> *)menu {
//    if (menu.empty) return nil;
//    self.menuSheet.clear;
//    for (CSMenuHeader *menuHeader in menu) {
//        CSMenuItem *item = menuHeader.items.first;
//        [self.menuSheet addAction:item.title :^{
//            item.action(item);
//        }];
//    }
//    return [UIBarButtonItem.alloc bk_initWithImage:CSMenuIcon.image style:UIBarButtonItemStylePlain handler:^(id sender) {
//        if (_menuSheet.visible) [_menuSheet hide];
//        else [_menuSheet showFromBarItem:sender];
//    }];
//}
//
//- (void)onPrepareRightBarButtonItems:(NSMutableArray<UIBarButtonItem *> *)array {
//}
//
//- (void)addChildViewController:(UIViewController *)childController {
//    [super addChildViewController:childController];
//    if ([childController isKindOfClass:CSMainController.class]) [self addChildMainController:(CSMainController *) childController];
//}
//
//- (UIViewController *)dismissChildController:(UIViewController *)controller {
//    [super dismissChildController:controller];
//    if ([controller isKindOfClass:CSMainController.class]) [_childMainControllers remove:controller];
//    return controller;
//}
//
//- (NSArray<CSMainController *> *)setChildMainControllers:(NSArray<CSMainController *> *)controllers {
//    [_childMainControllers removeAllObjects];
//    [self addChildMainControllers:controllers];
//    return controllers;
//}
//
//- (NSArray<CSMainController *> *)addChildMainControllers:(NSArray<CSMainController *> *)controllers {
//    for (CSMainController *controller in controllers)
//        [self addChildMainController:controller];
//    return controllers;
//}
//
//- (void)addChildMainController:(CSMainController *)childController {
//    [_childMainControllers put:childController];
//    childController.parentMain = self;
//}
//
//- (void)onPrepareMenu:(NSMutableArray<CSMenuHeader *> *)menu {
//    for (CSMenuHeader *menuHeader in _menu) if (menuHeader.visible) [menu put:menuHeader];
//    for (CSMainController *controller in _childMainControllers) if (controller.showing) [controller onPrepareMenu:menu];
//}
//
//- (UIBarButtonItem *)onPrepareLeftBarItem {
//    for (CSMainController *controller in _childMainControllers) if (controller.showing) return controller.onPrepareLeftBarItem;
//    return nil;
//}
//
//- (instancetype)showIn:(CSMainController *)parent {
//    CATransition *transition = CATransition.animation;
//    transition.duration = 0.15;
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    transition.type = kCATransitionMoveIn;
//    transition.subtype = kCATransitionFromBottom;
//    [self.view.layer addAnimation:transition forKey:nil];
//    [parent showChildController:self];
//    self.showing = YES;
//    return self;
//}
//
//- (instancetype)hideIn {
//    self.showing = NO;
//    [UIView animateWithDuration:0.5
//                     animations:^{self.view.bottom = -5;}
//                     completion:^(BOOL finished) {
//                         self.view.hide;
//                         [_parentMain dismissChildController:self];
//                     }];
//    return self;
//}
//
//@end
