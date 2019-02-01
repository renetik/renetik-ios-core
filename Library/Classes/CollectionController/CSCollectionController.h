//
// Created by Rene Dohan on 28/10/14.
// Copyright (c) 2014 Rene Dohan. All rights reserved.
//

@import UIKit;

@class CSResponse;

@interface CSCollectionController : NSObject

@property(nonatomic, strong, readonly) UICollectionView *collectionView;

@property(nonatomic, copy) CSResponse *(^onReload)(BOOL userRefresh);

@property(nonatomic, copy) CSResponse *(^onLoadNext)(void);

@property(nonatomic, strong) UIView *emptyLabel;

@property(nonatomic, strong) NSMutableArray *data;

@property(nonatomic, copy) BOOL (^onUserRefresh)(void);

- (CSCollectionController *)from:(UICollectionView *)collectionView :(UIView *)loadNextIndicator :(NSMutableArray *)data;

- (void)viewWillAppear;

- (void)onLoadSuccess:(NSArray *)array;

- (void)onLoadNextSuccess:(NSArray *)array;

- (CSResponse *)reload;

- (void)updateEmpty;

- (void)addItem:(id)dog;

- (void)insertItem:(id)item :(int)index;

- (void)removeItem:(id)item;

- (void)removeItemAtIndex:(NSUInteger)i;

- (void)collectionView:(UICollectionView *)view cellForItemAtIndexPath:(NSIndexPath *)path;
@end
