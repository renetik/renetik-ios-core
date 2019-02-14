//
// Created by Rene Dohan on 24/2/17.
// Copyright (c) 2017 renetik_software. All rights reserved.
//

@import Foundation;


@interface CSRefreshControl : NSObject
- (CSRefreshControl *)construct:(UIScrollView *)scrollView :(id)target :(SEL)pSelector;

- (CSRefreshControl *)construct:(UIScrollView *)scrollView :(void (^)(void))refreshingAction;

- (void)endRefreshing;

@end
