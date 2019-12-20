////
//// Created by Rene Dohan on 05/03/15.
//// Copyright (c) 2015 creative_studio. All rights reserved.
////
//
//@import UIKit;
//
//#import "CSArgEvent.h"
//
//NS_ASSUME_NONNULL_BEGIN
//
//@interface CSViewController : UIViewController
//
//@property(nonatomic) BOOL showing;
//@property(nonatomic, readonly) BOOL appearing;
//@property(nonatomic, readonly) BOOL visible;
//@property(nonatomic, readonly) CSArgEvent<id> *onOrientationChanging;
//@property(nonatomic, readonly) CSArgEvent<id> *onOrientationChanged;
//
//- (void)onViewDidLoad;
//
//- (void)onViewWillAppear;
//
//- (void)onViewWillAppearFirstTime;
//
//- (void)onCreateLayout;
//
//- (void)onLayoutCreated;
//
//- (void)onUpdateLayout;
//
//- (void)onViewDidLayout;
//
//- (void)onViewWillAppearFromPresentedController;
//
//- (void)onViewDidAppear;
//
//- (void)onViewDidAppearFirstTime;
//
//- (void)onViewDidAppearFromPresentedController;
//
//- (void)onViewWillDisappear;
//
//- (void)onViewPushedOver;
//
//- (void)onViewDismissing;
//
//- (void)viewDidDisappear;
//
//- (void)onViewVisibilityChanged:(BOOL)visible;
//
//- (void)onViewShowing;
//
//- (void)onViewHiding;
//
//- (void)onViewWillTransitionToSize
//        :(CGSize)size :(id <UIViewControllerTransitionCoordinator>)coordinator;
//
//- (void)onViewWillTransitionToSizeCompletion
//        :(CGSize)size :(id <UIViewControllerTransitionCoordinatorContext>)context;
//
//- (void)observer:(NSNotificationName)name
//        :(void (^)(NSNotification *note))block;
//
//- (CSEventRegistration *)register:(CSEventRegistration *)registration
//NS_SWIFT_NAME(register(event:));
//
//- (void)cancel:(CSEventRegistration *)registration
//NS_SWIFT_NAME(cancel(registration:));
//
//- (BOOL)isInNavigationController;
//
//- (nullable UIViewController *)controllerInNavigation;
//
//- (void)setShouldAutorotate:(BOOL)shouldAutorotate;
//
//- (void)clearShouldAutorotate;
//
//@end
//
//NS_ASSUME_NONNULL_END
