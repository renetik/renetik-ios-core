//
// Created by Rene Dohan on 29/10/15.
// Copyright (c) 2015 creative_studio. All rights reserved.
//

@import UIKit;

#import "CSViewController.h"

@class CSMenuItem;
@class CSMenuHeader;

@interface CSMainController : CSViewController

@property(nonatomic, strong) NSMutableArray<CSMenuHeader *> *menu;

@property(nonatomic, strong) CSMainController *parent;

- (NSArray<CSMainController *> *)setChildMainControllers:(NSArray<CSMainController *> *)controllers;

- (NSArray<CSMainController *> *)addChildMainControllers:(NSArray<CSMainController *> *)controllers;

- (UIBarButtonItem *)onCreateMenu:(NSMutableArray<CSMenuItem *> *)menuItems;

- (void)onPrepareRightBarButtonItems:(NSMutableArray<UIBarButtonItem *> *)array;

- (instancetype)showIn:(CSMainController *)parent;

- (void)hideIn:(UIViewController *)parent;

- (CSMenuHeader *)menuHeader:(NSString *)title;

- (CSMenuItem *)menuItemView:(UIView *)view;

- (CSMenuHeader *)menuHeader;

- (CSMenuItem *)menuItem:(NSString *)title;

- (CSMenuItem *)menuItem:(NSString *)title :(NSString *)description :(void (^)(CSMenuItem *))onClick;

- (CSMenuItem *)menuItem:(NSString *)title :(void (^)(CSMenuItem *))onClick;

- (CSMenuItem *)menuItem:(NSString *)title type:(UIBarButtonSystemItem)item;

- (CSMenuItem *)menuItem:(NSString *)title image:(UIImage *)image;

- (CSMenuItem *)menuItemImage:(UIImage *)image;

- (CSMenuItem *)menuItem:(NSString *)title :(UIImage *)image :(NSString *)note :(void (^)(CSMenuItem *))onClick;

- (CSMenuItem *)menuItem:(NSString *)title type:(UIBarButtonSystemItem)type :(void (^)(CSMenuItem *))onClick;

- (CSMenuItem *)menuItem:(NSString *)title :(NSString *)description type:(UIBarButtonSystemItem)type :(void (^)(CSMenuItem *))onClick;

- (CSMenuItem *)menuItem;

- (BOOL)isMainController;

- (BOOL)isChildController;

- (void)onPrepareMenu:(NSMutableArray<CSMenuHeader *> *)items;

- (UIBarButtonItem *)onPrepareLeftBarItem;

- (void)updateBarItemsAndMenu;

- (void)updateBarItemsAndMenu:(BOOL)animated;
@end