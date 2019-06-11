//
// Created by Rene Dohan on 26/10/15.
// Copyright (c) 2015 creative_studio. All rights reserved.
//

#import "CSTabPagerController.h"
#import "CSTabPagerTabProtocol.h"

@implementation CSTabPagerController {
    NSArray<CSMainController <CSTabPagerTabProtocol>*>*_controllers;
    CSMainController*_parentController;
    UITabBar*_tabBar;
    UIScrollView*_scrollView;
    NSUInteger _currentIndex;
    UIView*_contentView;
}

- (instancetype)construct:(CSMainController*)parent :(NSArray<CSMainController <CSTabPagerTabProtocol>*>*)controllers
    :(UITabBar*)toolbar :(UIScrollView*)scrollView {
    [super construct:parent];
    _parentController = parent;
    _controllers = controllers;
    _tabBar = toolbar;
    _tabBar.delegate = self;
    _scrollView = scrollView;
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.scrollsToTop = NO;
    _scrollView.directionalLockEnabled = YES;
    _contentView = [UIView createEmptyWithColor:UIColor.clearColor frame:_scrollView.bounds];
    [[_scrollView addView:_contentView] matchParent];
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    invoke(^{ [self reload:_controllers]; });
    [self updateAppearance];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView*)view {
    [self onPageChange:(NSUInteger)lround(_scrollView.contentOffset.x / (_scrollView.contentSize.width / _controllers.count))];
    [self showSelectEffect];
}

- (void)reload:(nonnull NSArray*)controllers {
    if(controllers.empty) return;
    for(UIViewController*controller in _controllers)
        [_parentController removeController:controller];
    _controllers = controllers;
    [self loadBar];
    _scrollView.contentSize =
        CGSizeMake(_contentView.width = _controllers.count * _scrollView.width, 0);

    for(CSMainController*controller in _controllers) {
        [_contentView positionViewNextLast:controller.view];
        [_parentController addController:controller :_contentView];
//		controller.view.matchParentHeight;
        controller.view.size = _scrollView.size;
        [controller.view setNeedsUpdateConstraints];
    }
    [self selectTab:_currentIndex];
}

- (void)loadBar {
    NSMutableArray*items = NSMutableArray.new;
    for(CSMainController <CSTabPagerTabProtocol>*controller in _controllers)
        [items add:[controller tabItem]];
    [_tabBar setItems:items];
}

- (void)tabBar:(UITabBar*)tabBar didSelectItem:(UITabBarItem*)item {
    [self onPageChange:[tabBar.items indexOfObject:item]];
    [self showPage];
}

- (void)selectTab:(NSUInteger)pageIndex {
    [self onPageChange:pageIndex];
    [self showPage];
    [self showSelectEffect];
}

- (void)onPageChange:(NSUInteger)pageIndex {
    _controllers[_currentIndex].showing = NO;
    _currentIndex = pageIndex;
    _controllers[_currentIndex].showing = YES;
    [_parentController updateBarItemsAndMenu];
}

- (void)showPage {
    [_scrollView scrollToPage:_currentIndex of:_controllers.count];
}

- (void)showSelectEffect {
    _tabBar.selectedItem = _tabBar.items[_currentIndex];
}

- (void)onViewWillTransitionToSizeCompletion:(CGSize)size :(id <UIViewControllerTransitionCoordinatorContext>)context {
    [super onViewWillTransitionToSizeCompletion:size :context];
    [self reload:_controllers];
    [self updateAppearance];
}

- (void)updateAppearance {
    if(UIDevice.isPortrait) [_scrollView setBottomToHeight:_tabBar.top];
	else _scrollView.height = _scrollView.superview.height;
	_tabBar.hidden = UIDevice.isLandscape;
}

@end
