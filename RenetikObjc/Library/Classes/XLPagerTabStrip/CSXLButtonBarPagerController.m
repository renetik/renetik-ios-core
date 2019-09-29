//
// Created by Rene Dohan on 26/2/17.
// Copyright (c) 2017 Renetik Software. All rights reserved.
//

@import UIKit;

#import "CSXLButtonBarPagerController.h"
#import "CSMainController.h"
#import "CSLang.h"
#import "UIViewController+CSExtension.h"
#import "NSArray+CSExtension.h"
#import "NSMutableArray+CSExtension.h"
#import "UIView+CSPosition.h"
#import "UIView+CSDimension.h"
#import "UIView+CSLayout.h"

@implementation CSXLButtonBarPagerController {
    NSMutableArray<CSMainController <XLPagerTabStripChildItem>*>*_controllers;
    CSMainController*_parent;
    NSInteger _currentIndex;
    CGFloat _buttonBarViewHeightBeforeHide;
}

- (instancetype)setup :(CSMainController*)parent :(NSArray<CSMainController <XLPagerTabStripChildItem>*>*)controllers {
    _parent = parent;
    _controllers = controllers.mutableCopy;
    [_parent showChildController:self];
    [_parent addChildMainControllers:_controllers];
    return self;
}

- (NSArray*)childViewControllersForPagerTabStripViewController :(XLPagerTabStripViewController*)pagerTabStripViewController {
    return _controllers;
}

- (void)viewWillLayoutSubviews {
    if(_controllers.hasItems) [super viewWillLayoutSubviews];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateControllersVisible:self.currentIndex:NO];
}

- (void)viewDidAppear :(BOOL)animated {
    [super viewDidAppear:animated];
    [self reloadPagerTabStripView];
}

- (void)pagerTabStripViewController :(XLPagerTabStripViewController*)pagerTabStripViewController updateIndicatorFromIndex :(NSInteger)fromIndex toIndex :(NSInteger)toIndex {
    [super pagerTabStripViewController:pagerTabStripViewController updateIndicatorFromIndex:fromIndex toIndex:toIndex];
    [self updateControllersVisible:toIndex :YES];
}

- (void)pagerTabStripViewController :(XLPagerTabStripViewController*)pagerTabStripViewController updateIndicatorFromIndex :(NSInteger)fromIndex toIndex :(NSInteger)toIndex withProgressPercentage :(CGFloat)progressPercentage indexWasChanged :(BOOL)indexWasChanged {
    [super pagerTabStripViewController:pagerTabStripViewController updateIndicatorFromIndex:fromIndex toIndex:toIndex
                withProgressPercentage:progressPercentage
                       indexWasChanged:indexWasChanged];
    if(progressPercentage == 1) [self updateControllersVisible:toIndex :NO];
}

- (void)updateControllersVisible :(NSInteger)index :(BOOL)animated {
    _currentIndex = index;
    for(CSMainController*controller in _controllers) controller.showing = NO;
    self.currentController.showing = YES;
    [_parent updateBarItemsAndMenu:animated];
}

- (void)load :(NSArray<UIViewController <XLPagerTabStripChildItem>*>*)controllers {
    _controllers = controllers.mutableCopy;
    [_parent addChildMainControllers:_controllers];
    self.reloadPagerTabStripView;
    [self updateControllersVisible:self.currentIndex:NO];
}

- (void)add :(UIViewController <XLPagerTabStripChildItem>*)controller {
    [_controllers put:controller];
    [_parent addChildMainController:controller];
    [self reloadPagerTabStripView];
    [self updateControllersVisible:self.currentIndex:NO];
}

- (CSMainController <XLPagerTabStripChildItem>*)currentController {
    return _controllers[(NSUInteger)_currentIndex];
}

- (NSInteger)selectedIndex {
    return _currentIndex;
}

- (void)viewWillTransitionToSize :(CGSize)size withTransitionCoordinator :(id <UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [coordinator animateAlongsideTransition:nil completion:^(id <UIViewControllerTransitionCoordinatorContext> context) {
        self.reloadPagerTabStripView;
        [self updateControllersVisible:self.currentIndex:NO];
    }];
}

- (void)setBarVisible :(BOOL)visible {
    if(visible) {
        if(_buttonBarViewHeightBeforeHide == 0) return;
        self.buttonBarView.height = _buttonBarViewHeightBeforeHide;
        [self.containerView heightFromTop:_buttonBarViewHeightBeforeHide];
        _buttonBarViewHeightBeforeHide = 0;
    } else {
        _buttonBarViewHeightBeforeHide = self.buttonBarView.height;
        self.buttonBarView.height = 0;
        [self.containerView heightFromTop:0];
    }
}

@end
