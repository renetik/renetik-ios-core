//
// Created by Rene Dohan on 05/11/14.
// Copyright (c) 2014 Rene Dohan. All rights reserved.
//

#import "UICollectionView+CSExtension.h"


@implementation UICollectionView (CSExtension)

static NSString *const EMPTY_CELL = @"emptyCellIdentifier";
static NSString *const EMPTY_HEADER = @"emptyHeaderIdentifier";

- (instancetype)setup:(id <UICollectionViewDelegate, UICollectionViewDataSource>)parent {
    [super construct];
    self.delegate = parent;
    self.dataSource = parent;
    [self registerEmptyForCell];
    [self reloadData];
    return self;
}

- (__kindof UICollectionViewCell *)dequeueCell:(NSString *)identifier :(NSIndexPath *)path {
    return [self dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:path];
}

- (__kindof UICollectionViewCell *)dequeueCellForView:(Class)identifier :(NSIndexPath *)path {
    return [self dequeueReusableCellWithReuseIdentifier:[identifier description] forIndexPath:path];
}

- (void)registerEmptyForCell {
    [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:EMPTY_CELL];
}

- (void)registerEmptyViewForHeader {
    [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:EMPTY_HEADER];
}

- (UICollectionViewCell *)createCell:(Class)viewClass :(NSIndexPath *)path {
    UICollectionViewCell *cell = [self dequeEmptyCell:path];
    if (!cell.contentView.subviews.first) {
        UIView *view = [viewClass.create construct];
//    self.rowHeight = view.height;
        [cell.contentView addSubview:view];
        [cell.contentView.subviews.first matchParent];
    }
    return cell;
}

- (UICollectionViewCell *)dequeEmptyCell:(NSIndexPath *)path {
    return [self dequeueCell:EMPTY_CELL :path];
}

- (UICollectionReusableView *)dequeEmptyHeader:(NSIndexPath *)path {
    return [self dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                    withReuseIdentifier:EMPTY_HEADER forIndexPath:path];
}

- (void)registerNibForCell:(Class)pClass {
    [self registerNib:[UINib nibWithName:pClass.NIBName] forCellWithReuseIdentifier:[pClass description]];
}
@end
