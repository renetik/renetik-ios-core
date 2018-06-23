//
// Created by Rene Dohan on 26/2/17.
// Copyright (c) 2017 Renetik Software. All rights reserved.
//

#import "CSXLButtonBarPagerController.h"
#import "CSMainController.h"

@implementation CSXLButtonBarPagerController {
    NSArray<CSMainController <XLPagerTabStripChildItem> *> *_controllers;
    CSMainController *_parent;
    NSInteger _currentIndex;
}

- (instancetype)construct:(CSMainController *)parent :(NSArray<CSMainController <XLPagerTabStripChildItem> *> *)controllers {
    [super construct];
    _parent = parent;
    _controllers = controllers;
    [_parent addControllers:_controllers];
    return self;
}

- (NSArray *)childViewControllersForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController {
    return _controllers;
}

- (void)viewWillLayoutSubviews {
    if (_controllers.hasItems) [super viewWillLayoutSubviews];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateControllersVisible:self.currentIndex :NO];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self reloadPagerTabStripView];
}

- (void)pagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController updateIndicatorFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    [super pagerTabStripViewController:pagerTabStripViewController updateIndicatorFromIndex:fromIndex toIndex:toIndex];
    [self updateControllersVisible:toIndex :YES];
}

- (void)pagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController updateIndicatorFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex withProgressPercentage:(CGFloat)progressPercentage indexWasChanged:(BOOL)indexWasChanged {
    [super pagerTabStripViewController:pagerTabStripViewController updateIndicatorFromIndex:fromIndex toIndex:toIndex withProgressPercentage:progressPercentage indexWasChanged:indexWasChanged];
    if (progressPercentage == 1) [self updateControllersVisible:toIndex :NO];
}

- (void)updateControllersVisible:(NSInteger)index :(BOOL)animated {
    _currentIndex = index;
    for (CSMainController *controller in _controllers)controller.showing = NO;
    self.currentController.showing = YES;
    [_parent updateBarItemsAndMenu:animated];
}

- (void)load:(NSMutableArray<CSMainController <XLPagerTabStripChildItem> *> *)controllers {
    _controllers = controllers;
    [_parent addControllers:_controllers];
    [self reloadPagerTabStripView];
    [self updateControllersVisible:self.currentIndex :NO];
}

- (CSMainController <XLPagerTabStripChildItem> *)currentController {
    return _controllers[(NSUInteger) _currentIndex];
}

- (NSInteger)selectedIndex {
    return _currentIndex;
}

@end