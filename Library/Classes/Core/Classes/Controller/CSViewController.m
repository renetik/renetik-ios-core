//
// Created by Rene Dohan on 05/03/15.
// Copyright (c) 2015 creative_studio. All rights reserved.
//

#import "CSViewController.h"

@implementation CSViewController {
    BOOL _didLayoutSubviews;
    BOOL _onViewWillAppearFirstTime;
    BOOL _onViewDidAppearFirstTime;
}

- (instancetype)construct {
    [super construct];
    _didLayoutSubviews = NO;
    _onViewWillAppearFirstTime = NO;
    _onViewDidAppearFirstTime = NO;
    _showing = NO;
    return self;
}

- (void)loadView {
    self.view = UIView.new;
}

- (void)viewDidLoad {
    super.viewDidLoad;
    self.onViewDidLoad;
}

- (void)onViewDidLoad {}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self onViewWillAppear];
    if (!_onViewWillAppearFirstTime) {
        _onViewWillAppearFirstTime = YES;
        [self onViewWillAppearFirstTime];
    } else [self onViewWillAppearFromPresentedController];
}

- (void)onViewWillAppear {}

- (void)onViewWillAppearFirstTime {}

- (void)onViewWillAppearFromPresentedController {}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (!_didLayoutSubviews) {
        _didLayoutSubviews = YES;
        [self onInitialViewDidLayoutSubviews];
        [self onCreateLayout];
        [self onLayoutCreated];
    } else [self onUpdateLayout];
}

- (void)onInitialViewDidLayoutSubviews {}

- (void)onCreateLayout {}

- (void)onLayoutCreated {}

- (void)onUpdateLayout {}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.appearing = YES;
    [self onViewDidAppear];
    if (!_onViewDidAppearFirstTime) {
        _onViewDidAppearFirstTime = YES;
        [self onViewDidAppearFirstTime];
    } else [self onViewDidAppearFromPresentedController];
}

- (void)onViewDidAppear {}

- (void)onViewDidAppearFirstTime {}

- (void)onViewDidAppearFromPresentedController {}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self viewWillDisappear];
    if (self.isMovingFromParentViewController) [self onViewDismissing];
}

- (void)viewWillDisappear {}

- (void)onViewDismissing {[self removeNotificationObserver];}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.appearing = NO;
    [self viewDidDisappear];
}

- (void)viewDidDisappear {}

- (void)setShowing:(BOOL)showing {
    if (_showing == showing) return;
    _showing = showing;
    [self onViewVisibilityChanged:showing];
    if (showing) [self onViewShowing];
    else [self onViewHiding];
}

- (void)onViewVisibilityChanged:(BOOL)visible {}

- (void)onViewShowing {}

- (void)onViewHiding {}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [coordinator animateAlongsideTransition:nil completion:^(id <UIViewControllerTransitionCoordinatorContext> context) {
        [self onViewWillTransitionToSizeCompletion:size :context];
    }];
}

- (void)onViewWillTransitionToSizeCompletion:(CGSize)size
        :(id <UIViewControllerTransitionCoordinatorContext>)context {}

- (BOOL)visible {
    return self.appearing && self.showing;
}

@end
