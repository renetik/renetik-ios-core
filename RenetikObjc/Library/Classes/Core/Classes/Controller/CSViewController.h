//
// Created by Rene Dohan on 05/03/15.
// Copyright (c) 2015 creative_studio. All rights reserved.
//

@import UIKit;

@class CSEventRegistration;

NS_ASSUME_NONNULL_BEGIN
@interface CSViewController: UIViewController

@property (nonatomic) BOOL showing;
@property (nonatomic) BOOL appearing;
@property (nonatomic, readonly) BOOL visible;

- (void)onViewDidLoad;

- (void)onViewWillAppear;

- (void)onViewWillAppearFirstTime;

- (void)onInitialViewDidLayoutSubviews;

- (void)onCreateLayout;

- (void)onLayoutCreated;

- (void)onUpdateLayout;

- (void)onViewDidLayout;

- (void)onViewWillAppearFromPresentedController;

- (void)onViewDidAppear;

- (void)onViewDidAppearFirstTime;

- (void)onViewDidAppearFromPresentedController;

- (void)viewWillDisappear;

- (void)onViewDismissing;

- (void)viewDidDisappear;

- (void)onViewVisibilityChanged :(BOOL)visible;

- (void)onViewShowing;

- (void)onViewHiding;

- (void)onViewWillTransitionToSize
    :(CGSize)size:(id <UIViewControllerTransitionCoordinator>)coordinator;

- (void)onViewWillTransitionToSizeCompletion
    :(CGSize)size :(id <UIViewControllerTransitionCoordinatorContext>)context;

- (void)observer :(NSNotificationName)name
    :(void (^)(NSNotification*note))block;

- (void)register :(CSEventRegistration*)registration;
@end
NS_ASSUME_NONNULL_END
