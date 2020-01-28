//
// Created by Rene Dohan on 05/11/14.
// Copyright (c) 2014 Rene Dohan. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN
@interface UICollectionView (CSExtension)

- (instancetype)delegates :(id <UICollectionViewDelegate, UICollectionViewDataSource>)parent;

- (instancetype)layout :(UICollectionViewLayout *)layout;

- (__kindof UICollectionViewCell *)dequeueCell :(NSString *)identifier :(NSIndexPath *)path;

- (__kindof UICollectionViewCell *)dequeueCellForView :(Class)identifier :(NSIndexPath *)path;

- (instancetype)registerForCellView;

- (instancetype)registerDefaultCell :(Class)cellClass;

- (instancetype)registerEmptyHeader;

//- (UICollectionViewCell *)cellView :(Class)viewClass :(NSIndexPath *)path :(void (^)(UICollectionViewCell *))onCreate;

- (__kindof UICollectionReusableView *)dequeEmptyHeader :(NSIndexPath *)path;

@end
NS_ASSUME_NONNULL_END
