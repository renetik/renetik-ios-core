//
// Created by Rene Dohan on 05/03/15.
// Copyright (c) 2015 creative_studio. All rights reserved.
//

#import "CSViewController.h"


@implementation CSViewController {
    BOOL _didLayoutSubviews;
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (!_didLayoutSubviews) {
        _didLayoutSubviews = YES;
        [self onInitialViewDidLayoutSubviews];
    }
}

- (void)onInitialViewDidLayoutSubviews {

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isActive = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.isActive = NO;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

@end
