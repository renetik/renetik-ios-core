//
// Created by Rene Dohan on 29/10/15.
// Copyright (c) 2015 creative_studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSViewController.h"

@class CSMenuItem;
@class CSMenuHeader;
@class CSActionSheet;

@interface CSMainController : CSViewController

@property(nonatomic) BOOL showing;
@property(nonatomic) BOOL appearing;
@property(nonatomic, readonly) BOOL visible;
@property(nonatomic, strong) NSMutableArray<CSMenuHeader *> *menu;
@property(nonatomic, strong) CSMainController *parent;

- (instancetype)construct:(CSMainController *)parent;

- (NSArray<CSMainController *> *)setControllers:(NSArray<CSMainController *> *)controllers;

- (NSArray<CSMainController *> *)addControllers:(NSArray<CSMainController *> *)controllers;

- (UIBarButtonItem *)onCreateMenu:(NSMutableArray<CSMenuItem *> *)menuItems;

- (void)onPrepareRightBarButtonItems:(NSMutableArray<UIBarButtonItem *> *)array;

- (void)viewWillDisappear;

- (void)onViewDismissing;

- (void)showIn:(CSMainController *)parent;

- (void)hideIn:(UIViewController *)parent;

- (CSMenuHeader *)menuHeader:(NSString *)title;

- (CSMenuItem *)menuItemView:(UIView *)view;

- (CSMenuHeader *)menuHeader;

- (CSMenuItem *)menuItem:(NSString *)title;

- (CSMenuItem *)menuItem:(NSString *)title :(NSString *)description :(void (^)(CSMenuItem *))onClick;

- (CSMenuItem *)menuItem:(NSString *)title :(void (^)(CSMenuItem *))onClick;

- (CSMenuItem *)menuItem:(NSString *)title type:(UIBarButtonSystemItem)item;

- (CSMenuItem *)menuItem:(NSString *)title image:(UIImage *)image;

- (CSMenuItem *)menuItem:(NSString *)title :(UIImage *)image :(NSString *)note :(void (^)(CSMenuItem *))onClick;

- (CSMenuItem *)menuItem:(NSString *)title type:(UIBarButtonSystemItem)type :(void (^)(CSMenuItem *))onClick;

- (CSMenuItem *)menuItem:(NSString *)title :(NSString *)description type:(UIBarButtonSystemItem)type :(void (^)(CSMenuItem *))onClick;

- (CSMenuItem *)menuItem;

- (void)viewDidDisappear;

- (void)onViewShowing;

- (BOOL)isMainController;

- (BOOL)isChildController;

- (void)onViewWillAppear;

- (void)onViewWillAppearFirstTime;

- (void)onViewWillAppearFromPresentedController;

- (void)onViewDidAppearFirstTime;

- (void)onViewDidAppear;

- (void)onViewDidAppearFromPresentedController;

- (void)onViewWillTransitionToSizeCompletion:(CGSize)size :(id <UIViewControllerTransitionCoordinatorContext>)context;

- (void)onPrepareMenu:(NSMutableArray<CSMenuHeader *> *)items;

- (UIBarButtonItem *)onPrepareLeftBarItem;

- (void)updateBarItemsAndMenu;

- (void)updateBarItemsAndMenu:(BOOL)animated;
@end