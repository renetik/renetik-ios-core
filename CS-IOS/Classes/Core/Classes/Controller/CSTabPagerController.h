//
// Created by Rene Dohan on 26/10/15.
// Copyright (c) 2015 creative_studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSViewController.h"
#import "CSChildViewLessController.h"

@class CSMainController;
@class CSMainController;
@protocol CSTabPagerTabProtocol;

@interface CSTabPagerController : CSChildViewLessController <UIScrollViewDelegate, UITabBarDelegate>

- (void)onPageChange:(NSUInteger)pageIndex;

- (instancetype)construct:(CSMainController *)parentController :(NSArray<CSMainController <CSTabPagerTabProtocol> *> *)controllers :(UITabBar *)tabBar :(UIScrollView *)scrollView;

- (void)reload:(NSArray *)array;

@end