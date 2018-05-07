//
// Created by Rene Dohan on 28/10/14.
// Copyright (c) 2014 Rene Dohan. All rights reserved.
//

#import "CSCollectionController.h"
#import "CSResponse.h"

@implementation CSCollectionController {
    UIView *_loadNextIndicator;
    BOOL _noNext;
    BOOL _loading;
}

- (instancetype)from:(UICollectionView *)collectionView :(UIView *)loadNextIndicator :(NSMutableArray *)data {
    _collectionView = collectionView;
    _loadNextIndicator = loadNextIndicator;
    _loadNextIndicator.hidden = YES;
    _data = data;
    return self;
}

- (void)loadNext {
    if (_loading)return;
    _loading = YES;
    [_loadNextIndicator fadeIn];
    [_onLoadNext() onDone:^(id data) {
        [self onDone];
        [_loadNextIndicator fadeOut];
    }];
}

- (BOOL)shouldLoadNext:(NSIndexPath *)indexPath {
    if (_loading)return NO;
    if (!_onLoadNext)return NO;
    return !_noNext && indexPath.row >= _data.count - 5;
}

- (void)collectionView:(UICollectionView *)view cellForItemAtIndexPath:(NSIndexPath *)path {
    if ([self shouldLoadNext:path]) [self loadNext];
}

- (void)onRefreshControlInvoke {
    if (self.onUserRefresh) {
        if (self.onUserRefresh())[self load:YES];
    } else [self load:YES];
}

- (CSResponse *)reload {
    return [self load:NO];
}

- (CSResponse *)load:(BOOL)fromRefreshControl {
    self.emptyLabel.visible = NO;
    _noNext = NO;
    _loading = YES;
    return [self.onReload(fromRefreshControl) onDone:^(id data) {
        [self onDone];
    }];
}

- (void)setEmptyLabel:(UIView *)emptyLabel {
    _emptyLabel = emptyLabel;
    _emptyLabel.visible = NO;
}

- (void)onDone {
    _loading = NO;
    [self updateEmpty];
    [_collectionView fadeIn];
}

- (void)updateEmpty {
    _emptyLabel.fadeVisible = _data.empty;
    _emptyLabel.userInteractionEnabled = NO;
}

- (void)onLoadSuccess:(NSArray *)array {
    [_data replaceFromArray:array];
    _noNext = array.count == 0;
    [_collectionView reloadData];
    [self updateEmpty];
}

- (void)onLoadNextSuccess:(NSArray *)array {
    [self updateEmpty];
    _noNext = array.count == 0;
    if (_noNext)return;

    NSMutableArray *indexPaths = NSMutableArray.new;
    for (int i = 0; i < array.count; i++) [indexPaths addObject:[NSIndexPath indexPathForRow:i + _data.count inSection:0]];

    [_data addObjectsFromArray:array];
    [_collectionView insertItemsAtIndexPaths:indexPaths];
}

- (void)viewWillAppear {
    [_collectionView deselectItemAtIndexPath:_collectionView.indexPathsForSelectedItems[0] animated:YES];
    [_collectionView reloadData];
}

- (void)addItem:(id)item {
    [_data addObject:item];
    [_collectionView reloadData];
    [self updateEmpty];
}

- (void)insertItem:(id)item :(int)index {
    [_data insertObject:item atIndex:(uint) index];
    [_collectionView reloadData];
    [self updateEmpty];
}

- (void)removeItem:(id)item {
    [_data removeObject:item];
    [_collectionView reloadData];
    [self updateEmpty];
}

- (void)removeItemAtIndex:(NSUInteger)index {
    [_data removeObjectAtIndex:index];
    [_collectionView reloadData];
    [self updateEmpty];
}

@end