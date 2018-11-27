//
// Created by Rene Dohan on 30/4/17.
// Copyright (c) 2017 renetik_software. All rights reserved.
//

#import "CSXLSegmentedPagerController.h"
#import "CSMainController.h"

@implementation CSXLSegmentedPagerController {
    NSArray<CSMainController <XLPagerTabStripChildItem> *> *_controllers;
    CSMainController *_parent;
}

- (instancetype)construct:(CSMainController *)parent
        :(NSArray<CSMainController <XLPagerTabStripChildItem> *> *)controllers {
    [super construct];
    _parent = parent;
    _controllers = controllers;
    [parent addChildMainControllers:_controllers];
    return self;
}

- (NSArray *)childViewControllersForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController {
    return _controllers;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateControllersVisible:self.currentIndex];
}

- (void)moveToViewControllerAtIndex:(NSUInteger)index {
    [super moveToViewControllerAtIndex:index];
    [self updateControllersVisible:index];
}

- (void)updateControllersVisible:(NSUInteger)index {
    for (CSMainController *controller in _controllers)controller.showing = NO;
    _controllers[index].showing = YES;
    [_parent updateBarItemsAndMenu];
}

@end