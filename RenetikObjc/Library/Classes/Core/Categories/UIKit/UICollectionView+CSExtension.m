//
// Created by Rene Dohan on 05/11/14.
// Copyright (c) 2014 Rene Dohan. All rights reserved.
//

#import "UICollectionView+CSExtension.h"
#import "CSLang.h"
#import "NSObject+CSExtension.h"
#import "NSArray+CSExtension.h"
#import "UIView+CSExtension.h"
#import "UINib+CSExtension.h"
#import "UIView+CSDimension.h"
#import "UIView+CSContainer.h"

@implementation UICollectionView (CSExtension)

static NSString * const DEFAULT_CELL_ID = @"emptyCellIdentifier";
static NSString *const EMPTY_HEADER = @"emptyHeaderIdentifier";

- (instancetype)layout :(UICollectionViewLayout *)layout {
    [self setCollectionViewLayout :layout animated :false];
    return self;
}

- (__kindof UICollectionViewCell *)dequeueCell :(NSString *)identifier :(NSIndexPath *)path {
    return [self dequeueReusableCellWithReuseIdentifier :identifier forIndexPath :path];
}

- (__kindof UICollectionViewCell *)dequeueCellForView :(Class)identifier :(NSIndexPath *)path {
    return [self dequeueReusableCellWithReuseIdentifier :[identifier description] forIndexPath :path];
}

- (instancetype)registerForCellView {
    [self registerClass :[UICollectionViewCell class] forCellWithReuseIdentifier :DEFAULT_CELL_ID];
    return self;
}

- (instancetype)registerDefaultCell :(Class)cellClass {
    [self registerClass :cellClass forCellWithReuseIdentifier :DEFAULT_CELL_ID];
    return self;
}

- (instancetype)registerEmptyHeader {
    [self registerClass :[UICollectionReusableView class] forSupplementaryViewOfKind :UICollectionElementKindSectionHeader withReuseIdentifier :EMPTY_HEADER];
    return self;
}

- (UICollectionReusableView *)dequeEmptyHeader :(NSIndexPath *)path {
    return [self dequeueReusableSupplementaryViewOfKind :UICollectionElementKindSectionHeader
                                    withReuseIdentifier :EMPTY_HEADER forIndexPath :path];
}

@end
