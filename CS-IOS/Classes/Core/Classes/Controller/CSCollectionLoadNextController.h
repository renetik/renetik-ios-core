//
// Created by Rene Dohan on 10/9/16.
// Copyright (c) 2016 Bowbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSChildViewLessController.h"

@interface CSCollectionLoadNextController : CSChildViewLessController

- (instancetype)construct:(CSMainController *)parent :(UICollectionView *)view :(CSResponse *(^)())load :(UIColor *)color;

- (void)collectionViewCellForItemAtIndexPath:(NSIndexPath *)path :(NSMutableArray *)data;

- (NSMutableArray *)onLoadSuccess:(NSMutableArray *)array loaded:(NSArray *)loaded;

@end