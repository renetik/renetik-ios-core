//
// Created by Rene Dohan on 24/2/17.
// Copyright (c) 2017 renetik_software. All rights reserved.
//

#import <ChameleonFramework/ChameleonMacros.h>
#import <MJRefresh/MJRefresh.h>
#import "CSRefreshControl.h"


@implementation CSRefreshControl {
    UIScrollView *_scrollView;
}

- (CSRefreshControl *)construct:(UIScrollView *)scrollView :(id)target :(SEL)pSelector {
    _scrollView = scrollView;
    [self setup:scrollView header:[MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:pSelector]];
    return self;
}

- (CSRefreshControl *)construct:(UIScrollView *)scrollView :(void (^)())refreshingAction {
    _scrollView = scrollView;
    [self setup:scrollView header:[MJRefreshNormalHeader headerWithRefreshingBlock:refreshingAction]];
    return self;
}

- (void)setup:(UIScrollView *)scrollView header:(MJRefreshNormalHeader *)header {
    header.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    header.lastUpdatedTimeLabel.textColor = FlatGray;
    header.stateLabel.textColor = FlatGray;
    header.automaticallyChangeAlpha = YES;
    scrollView.mj_header = header;
    scrollView.alwaysBounceVertical = YES;
}

- (void)endRefreshing {
    [_scrollView.mj_header endRefreshing];
}


@end