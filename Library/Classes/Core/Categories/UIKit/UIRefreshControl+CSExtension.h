//
// Created by Rene Dohan on 31/1/17.
// Copyright (c) 2017 Renetik Software. All rights reserved.
//
@import UIKit;

@interface UIRefreshControl (CSExtension)
- (UIRefreshControl *)addRefreshControl:(UIScrollView *)control :(id)target :(SEL)action;
@end