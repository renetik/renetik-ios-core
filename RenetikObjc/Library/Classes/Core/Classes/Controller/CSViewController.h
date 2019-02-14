//
// Created by Rene Dohan on 05/03/15.
// Copyright (c) 2015 creative_studio. All rights reserved.
//

@import UIKit;

@interface CSViewController : UIViewController

@property(nonatomic) BOOL showing;
@property(nonatomic) BOOL appearing;
@property(nonatomic, readonly) BOOL visible;

- (void)onViewDidLoad;

- (void)onViewWillAppear;

- (void)onViewWillAppearFirstTime;

- (void)onInitialViewDidLayoutSubviews;

- (void)onCreateLayout;

- (void)onLayoutCreated;

- (void)onUpdateLayout;

- (void)onViewWillAppearFromPresentedController;

- (void)onViewDidAppear;

- (void)onViewDidAppearFirstTime;

- (void)onViewDidAppearFromPresentedController;

- (void)viewWillDisappear;

- (void)onViewDismissing;

- (void)viewDidDisappear;

- (void)onViewVisibilityChanged:(BOOL)visible;

- (void)onViewShowing;

- (void)onViewHiding;

- (void)onViewWillTransitionToSizeCompletion:(CGSize)size :(id <UIViewControllerTransitionCoordinatorContext>)context;
@end
