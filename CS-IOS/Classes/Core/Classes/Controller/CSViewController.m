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

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if(!_didLayoutSubviews) {
        _didLayoutSubviews = YES;
        [self onInitialViewDidLayoutSubviews];
    }
}

- (void)onInitialViewDidLayoutSubviews {
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isActive = YES;
    [self onViewWillAppear];
    if(!_onViewWillAppearFirstTime) {
        _onViewWillAppearFirstTime = YES;
        [self onViewWillAppearFirstTime];
    } else [self onViewWillAppearFromPresentedController];
}

- (void)onViewWillAppear {
}

- (void)onViewWillAppearFirstTime {
}

- (void)onViewWillAppearFromPresentedController {
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
	[UIViewController attemptRotationToDeviceOrientation];
    [self onViewDidAppear];
    if(!_onViewDidAppearFirstTime) {
        _onViewDidAppearFirstTime = YES;
        [self onViewDidAppearFirstTime];
    } else [self onViewDidAppearFromPresentedController];
}

- (void)onViewDidAppear {
}

- (void)onViewDidAppearFirstTime {
}

- (void)onViewDidAppearFromPresentedController {
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.isActive = NO;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [coordinator animateAlongsideTransition:nil completion:^(id <UIViewControllerTransitionCoordinatorContext> context) {
        [self onViewWillTransitionToSizeCompletion:size :context];
    }];
}

- (void)onViewWillTransitionToSizeCompletion:(CGSize)size :(id <UIViewControllerTransitionCoordinatorContext>)context {
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return true;
}

- (BOOL)shouldAutorotate {
    return true;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

@end
