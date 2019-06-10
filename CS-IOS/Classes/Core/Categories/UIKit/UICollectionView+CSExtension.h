//
// Created by Rene Dohan on 05/11/14.
// Copyright (c) 2014 Rene Dohan. All rights reserved.
//

@import UIKit;

@interface UICollectionView (CSExtension)
- (instancetype)setup:(id <UICollectionViewDelegate, UICollectionViewDataSource>)parent;

- (__kindof UICollectionViewCell *)dequeueCell:(NSString *)identifier :(NSIndexPath *)path;

- (__kindof UICollectionViewCell *)dequeueCellForView:(Class)identifier :(NSIndexPath *)path;

- (void)registerEmptyForCell;

- (void)registerEmptyViewForHeader;

- (UICollectionViewCell *)createCell:(Class)viewClass :(NSIndexPath *)path;

- (__kindof UICollectionViewCell *)dequeEmptyCell:(NSIndexPath *)path;

- (__kindof UICollectionReusableView *)dequeEmptyHeader:(NSIndexPath *)path;

- (void)registerNibForCell:(Class)pClass;

@end
