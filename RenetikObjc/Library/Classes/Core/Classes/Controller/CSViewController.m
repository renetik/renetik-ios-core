//
// Created by Rene Dohan on 05/03/15.
// Copyright (c) 2015 Renetik Software. All rights reserved.
//

#import "CSViewController.h"
#import "CSLang.h"
#import "UIViewController+CSExtension.h"
#import "UINavigationController+CSExtension.h"
#import "NSObject+CSExtension.h"
#import "CSEventRegistration.h"
#import "CSArgEvent.h"
#import "NSMutableArray+CSExtension.h"
#import "CSBool.h"

@implementation CSViewController {
    BOOL _didLayoutSubviews;
    BOOL _onViewWillAppearFirstTime;
    BOOL _onViewDidAppearFirstTime;
    NSMutableArray<NSObject *> *_notificationCenterObservers;
    NSMutableArray<CSEventRegistration *> *_eventRegistrations;
    CSBool *_shouldAutorotate;
}

- (instancetype)init {
    if (self == super.init) {
        _didLayoutSubviews = NO;
        _onViewWillAppearFirstTime = NO;
        _onViewDidAppearFirstTime = NO;
        _showing = NO;
        _notificationCenterObservers = NSMutableArray.new;
        _eventRegistrations = NSMutableArray.new;
        _onOrientationChanging = CSArgEvent.new;
        _onOrientationChanged = CSArgEvent.new;
    }
    return self;
}

- (void)loadView {
    self.view = UIView.new;
}

- (void)viewDidLoad {
    super.viewDidLoad;
    self.onViewDidLoad;
}

- (void)onViewDidLoad {
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.onViewWillAppear;
    if (!_onViewWillAppearFirstTime) {
        _onViewWillAppearFirstTime = YES;
        self.onViewWillAppearFirstTime;
    } else self.onViewWillAppearFromPresentedController;
}

- (void)onViewWillAppear {
}

- (void)onViewWillAppearFirstTime {
}

- (void)onViewWillAppearFromPresentedController {
}

- (void)viewDidLayoutSubviews {
    super.viewDidLayoutSubviews;
    if (!_didLayoutSubviews) {
        _didLayoutSubviews = YES;
        self.onCreateLayout;
        self.onLayoutCreated;
    } else self.onUpdateLayout;
    self.onViewDidLayout;
}

- (void)onCreateLayout {
}

- (void)onLayoutCreated {
}

- (void)onUpdateLayout {
}

- (void)onViewDidLayout {
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _appearing = YES;
    self.onViewDidAppear;
    if (!_onViewDidAppearFirstTime) {
        _onViewDidAppearFirstTime = YES;
        self.onViewDidAppearFirstTime;
    } else self.onViewDidAppearFromPresentedController;
}

- (void)onViewDidAppear {
}

- (void)onViewDidAppearFirstTime {
}

- (void)onViewDidAppearFromPresentedController {
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.onViewWillDisappear;
//    if (self.navigationController.previous == self.controllerInNavigation) self.onViewPushedOver;
}

- (void)onViewWillDisappear {
}

- (void)onViewDismissing {
    self.removeNotificationObserver;
    for (NSObject *observer in _notificationCenterObservers)
        [NSNotificationCenter.defaultCenter removeObserver:observer];
    for (CSEventRegistration *registration in _eventRegistrations)
        registration.cancel;
}

- (void)onViewPushedOver {
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    _appearing = NO;
    self.viewDidDisappear;
    if (!self.controllerInNavigation.parentViewController) self.onViewDismissing;
    if (self.navigationController.previous == self.controllerInNavigation) self.onViewPushedOver;
}

- (void)viewDidDisappear {
}

- (void)setShowing:(BOOL)showing {
    if (_showing == showing) return;
    _showing = showing;
    [self onViewVisibilityChanged:showing];
    if (showing) self.onViewShowing;
    else self.onViewHiding;
}

- (void)onViewVisibilityChanged:(BOOL)visible {
}

- (void)onViewShowing {
}

- (void)onViewHiding {
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    _onOrientationChanging.fire;
    [self onViewWillTransitionToSize:size :coordinator];
    [coordinator animateAlongsideTransition:nil completion:^(id <UIViewControllerTransitionCoordinatorContext> context) {
        [self onViewWillTransitionToSizeCompletion:size :context];
        _onOrientationChanged.fire;
    }];
}

- (void)onViewWillTransitionToSize
        :(CGSize)size :(id <UIViewControllerTransitionCoordinator>)coordinator {
}

- (void)onViewWillTransitionToSizeCompletion:(CGSize)size
        :(id <UIViewControllerTransitionCoordinatorContext>)context {
}

- (BOOL)visible {
    return self.appearing && self.showing;
}

- (void)observer:(NSNotificationName)name :(void (^)(NSNotification *note))block {
    let observer = [NSNotificationCenter.defaultCenter addObserverForName
    :name                                                          object:nil queue:nil usingBlock:block];
    [_notificationCenterObservers addObject:observer];
}

- (CSEventRegistration *)register:(CSEventRegistration *)registration {
    [_eventRegistrations put:registration];
    return registration;
}

- (void)cancel:(CSEventRegistration *)registration {
    [_eventRegistrations remove:registration];
    registration.cancel;
}

- (BOOL)isInNavigationController {
    if (self.controllerInNavigation) return true;
    return false;
}

- (UIViewController *)controllerInNavigation {
    if (self.parentViewController == self.navigationController) return self;
    UIViewController *controller = self;
    do controller = controller.parentViewController;
    while (controller &&
            controller.parentViewController != self.navigationController);
    return controller;
}

- (BOOL)shouldAutorotate {
    if (_shouldAutorotate) return _shouldAutorotate.value;
    return super.shouldAutorotate;
}

- (void)setShouldAutorotate:(BOOL)shouldAutorotate {
    _shouldAutorotate = [CSBool construct:shouldAutorotate];
}

- (void)clearShouldAutorotate {
    _shouldAutorotate = nil;
}

@end
