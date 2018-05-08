//
// Created by Rene Dohan on 26/10/15.
// Copyright (c) 2015 creative_studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MZAppearance/MZAppearance.h>
#import "CSViewController.h"
#import "CSChildViewLessController.h"

@class CSMainController;
@protocol CSToolbarPage;

@interface CSToolbarPagerController : CSChildViewLessController <UIScrollViewDelegate, MZAppearance>

- (instancetype)construct:(CSMainController *)parentController :(NSArray<CSMainController <CSToolbarPage> *> *)controllers :(UIToolbar *)toolBar :(UIScrollView *)scrollView;

@property(nonatomic) UIColor *selectedItemColor MZ_APPEARANCE_SELECTOR;
@property(nonatomic) UIColor *normalItemColor MZ_APPEARANCE_SELECTOR;
@property(nonatomic) NSUInteger currentIndex;

@property(nonatomic, strong) UIToolbar *toolBar;

@property(nonatomic, strong) NSArray<CSMainController <CSToolbarPage> *> *controllers;

- (void)onPageChange:(NSUInteger)pageIndex;

- (CSMainController <CSToolbarPage> *)currentController;

- (void)reload:(NSArray<CSMainController <CSToolbarPage> *> *)array;

@end