//
// Created by Rene Dohan on 26/2/17.
// Copyright (c) 2017 Renetik Software. All rights reserved.
//

@import XLPagerTabStrip;

@class CSMainController;

@interface CSXLButtonBarPagerController : XLButtonBarPagerTabStripViewController

@property(readonly) NSMutableArray<CSMainController <XLPagerTabStripChildItem> *> *controllers;
@property(readonly) CSMainController <XLPagerTabStripChildItem> *currentController;
@property(readonly) NSInteger selectedIndex;

- (instancetype)setup:(CSMainController *)parent :(NSArray<UIViewController <XLPagerTabStripChildItem> *> *)controllers;

- (void)load:(NSArray<UIViewController <XLPagerTabStripChildItem> *> *)controllers;

- (void)add:(UIViewController <XLPagerTabStripChildItem> *)controller;

- (void)setBarVisible:(BOOL)visible;

@end
