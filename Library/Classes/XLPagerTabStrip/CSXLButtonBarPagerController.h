//
// Created by Rene Dohan on 26/2/17.
// Copyright (c) 2017 Renetik Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XLPagerTabStrip/XLButtonBarPagerTabStripViewController.h>

@class CSMainController;

@interface CSXLButtonBarPagerController : XLButtonBarPagerTabStripViewController

- (instancetype)setup:(CSMainController *)parent :(NSArray<UIViewController <XLPagerTabStripChildItem> *> *)controllers;

- (void)load:(NSMutableArray<CSMainController <XLPagerTabStripChildItem> *> *)controllers;

- (CSMainController <XLPagerTabStripChildItem> *)currentController;

- (NSInteger)selectedIndex;

@end