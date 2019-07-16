//
// Created by Rene Dohan on 26/2/17.
// Copyright (c) 2017 Renetik Software. All rights reserved.
//

@import XLPagerTabStrip;

@class CSMainController;

@interface CSXLButtonBarPagerController: XLButtonBarPagerTabStripViewController

@property (readonly)
NSMutableArray<CSMainController <XLPagerTabStripChildItem>*>*controllers;

- (instancetype)setup :(CSMainController*)parent :(NSArray<UIViewController <XLPagerTabStripChildItem>*>*)controllers;

- (void)load
    :(NSArray<UIViewController <XLPagerTabStripChildItem>*>*)controllers;

- (void)add :(UIViewController <XLPagerTabStripChildItem>*)controller;

- (CSMainController <XLPagerTabStripChildItem>*)currentController;

- (NSInteger)selectedIndex;

- (void)setBarVisible :(BOOL)visible;

@end
