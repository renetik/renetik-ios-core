//
// Created by Rene Dohan on 29/10/15.
// Copyright (c) 2015 creative_studio. All rights reserved.
//

@import UIKit;

#import "CSViewController.h"

@class CSMenuItem;
@class CSMenuHeader;

NS_ASSUME_NONNULL_BEGIN
@interface CSMainController : CSViewController

@property (nonatomic, strong) NSMutableArray<CSMenuHeader *> *menu;

@property (nonatomic, strong) CSMainController *parentMain;

- (NSArray<CSMainController *> *)setChildMainControllers
    :(NSArray<CSMainController *> *)controllers;

- (NSArray<CSMainController *> *)addChildMainControllers
    :(NSArray<CSMainController *> *)controllers;

- (void)addChildMainController :(CSMainController *)childController;

- (UIBarButtonItem *)onCreateMenu :(NSMutableArray<CSMenuItem *> *)menuItems;

- (void)onPrepareRightBarButtonItems :(NSMutableArray<UIBarButtonItem *> *)array;

- (instancetype)showIn :(CSMainController *)parent;

- (instancetype)hideIn;

- (BOOL)isMainController;

- (BOOL)isChildController;

- (void)onPrepareMenu :(NSMutableArray<CSMenuHeader *> *)items;

- (UIBarButtonItem *)onPrepareLeftBarItem;

- (void)updateBarItemsAndMenu;

- (void)updateBarItemsAndMenu :(BOOL)animated;
@end
NS_ASSUME_NONNULL_END
