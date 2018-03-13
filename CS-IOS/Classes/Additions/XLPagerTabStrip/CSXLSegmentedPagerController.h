//
// Created by Rene Dohan on 30/4/17.
// Copyright (c) 2017 renetik_software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XLPagerTabStrip/XLSegmentedPagerTabStripViewController.h>

@class CSMainController;

@interface CSXLSegmentedPagerController : XLSegmentedPagerTabStripViewController

- (instancetype)construct:(CSMainController *)parent :
        (NSArray<UIViewController <XLPagerTabStripChildItem> *> *)controllers;

@end