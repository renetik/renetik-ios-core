//
// Created by Rene Dohan on 05/11/14.
// Copyright (c) 2014 Rene Dohan. All rights reserved.
//

#import "UICollectionView+CSExtension.h"
#import "NSObject+CSExtension.h"
#import "NSArray+CSExtension.h"
#import "UIView+CSExtension.h"
#import "UINib+CSExtension.h"
#import "UIView+CSDimension.h"
#import "UIView+CSLayout.h"

@implementation UICollectionView (CSExtension)

static NSString *const EMPTY_CELL = @"emptyCellIdentifier";
static NSString *const EMPTY_HEADER = @"emptyHeaderIdentifier";
static void *uiCollectionViewCellContent = &uiCollectionViewCellContent;

- (instancetype)construct {
    super.construct;
    self.backgroundColor = UIColor.clearColor;
    return self;
}

- (instancetype)setupCollection:(id <UICollectionViewDelegate, UICollectionViewDataSource>)parent {
    [self construct];
    self.delegate = parent;
    self.dataSource = parent;
    [self registerEmptyCell];
    [self reloadData];
    return self;
}

- (__kindof UICollectionViewCell *)dequeueCell:(NSString *)identifier :(NSIndexPath *)path {
    return [self dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:path];
}

- (__kindof UICollectionViewCell *)dequeueCellForView:(Class)identifier :(NSIndexPath *)path {
    return [self dequeueReusableCellWithReuseIdentifier:[identifier description] forIndexPath:path];
}

- (instancetype)registerEmptyCell {
    [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:EMPTY_CELL];
    return self;
}

- (instancetype)registerEmptyCell:(Class)cellClass {
    [self registerClass:cellClass forCellWithReuseIdentifier:EMPTY_CELL];
    return self;
}

- (instancetype)registerEmptyHeader {
    [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:EMPTY_HEADER];
    return self;
}

- (UICollectionViewCell *)emptyCell:(Class)viewClass :(NSIndexPath *)path :(void (^)(UICollectionViewCell *))onCreate {
    var cell = [self dequeueCell:EMPTY_CELL :path];
    if (![cell.contentView.subviews.last getObject:uiCollectionViewCellContent]) {
        [cell.contentView add:[viewClass.construct setObject:uiCollectionViewCellContent :@(YES)]].matchParent;
        invokeWith(onCreate, cell);
    }
    return cell;
}

- (UICollectionReusableView *)dequeEmptyHeader:(NSIndexPath *)path {
    return [self dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                    withReuseIdentifier:EMPTY_HEADER forIndexPath:path];
}


@end
