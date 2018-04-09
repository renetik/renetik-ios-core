//
// Created by Rene Dohan on 10/9/16.
// Copyright (c) 2016 Bowbook. All rights reserved.
//

#import "CSCollectionLoadNextController.h"
#import "CSResponse.h"


@implementation CSCollectionLoadNextController {
    UICollectionView *_collectionView;
    CSResponse *_loadResponse;
    BOOL _noNext;

    CSResponse *(^_loadBlock)();

    UIColor *_color;
}

- (instancetype)construct:(CSMainController *)parent :(UICollectionView *)view :(CSResponse *(^)())load :(UIColor *)color {
    [super construct:parent];
    _loadBlock = [load copy];
    _collectionView = view;
    _color = color;
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)collectionViewCellForItemAtIndexPath:(NSIndexPath *)path :(NSMutableArray *)data {
    if ([self shouldLoadNext:path :data]) {
        UIActivityIndicatorView *activityView = [UIActivityIndicatorView.alloc initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        activityView.color = _color;
        activityView.center = CGPointMake(_collectionView.center.x, _collectionView.bottom - activityView.height / 2);
        [activityView startAnimating];
        [_collectionView.superview addSubview:activityView];
        _loadResponse = [[_loadBlock() onSuccess:^(id o) {
            [_collectionView reloadData];
        }] onDone:^(id data) {
            [activityView removeFromSuperview];
            _loadResponse = nil;
        }];
    }
}

- (NSMutableArray *)onLoadSuccess:(NSMutableArray *)data loaded:(NSArray *)loaded {
    _noNext = loaded.count == 0;
    if (_noNext)return data;
    if (data) [data addObjectsFromArray:loaded];
    else data = [NSMutableArray arrayWithArray:loaded];
    return data;
}

- (BOOL)shouldLoadNext:(NSIndexPath *)path :(NSMutableArray *)data {
    if (_loadResponse)return NO;
    return !_noNext && path.index >= data.count - 5;
}

@end