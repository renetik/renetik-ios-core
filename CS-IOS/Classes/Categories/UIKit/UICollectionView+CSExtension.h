//
// Created by Rene Dohan on 05/11/14.
// Copyright (c) 2014 Rene Dohan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSLang.h"
#import "NSDictionary+CSExtension.h"
#import "NSArray+CSExtension.h"
#import "NSMutableArray+CSExtension.h"
#import "UIView+CSExtension.h"
#import "NSMutableDictionary+CSExtension.h"
#import "NSObject+CSExtension.h"
#import "UIViewController+CSExtension.h"
#import "UIImageView+CSExtension.h"
#import "NSIndexPath+CSExtension.h"
#import "UIDevice+CSExtension.h"
#import "UIScrollView+CSExtension.h"
#import "NSString+CSExtension.h"
#import "UIPickerView+CSExtension.h"
#import "NSLocale+CSExtension.h"
#import "NSUserDefaults+CSExtension.h"
#import "UIButton+CSExtension.h"
#import "UITableViewCell+CSExtension.h"
#import "UINavigationController+CSExtension.h"
#import "UIToolbar+CSExtension.h"
#import "UITableView+CSExtension.h"
#import "UIControl+CSExtension.h"
#import "UIImage+CSExtension.h"
#import "NSData+CSExtension.h"
#import "NSDate+CSExtensions2.h"
#import "NSDate+CSExtension.h"
#import "CSViewControllerProtocol.h"
#import "NSDateFormatter+CSExtension.h"
#import "UIColor+CSExtension.h"
#import "CALayer+CSExtension.h"
#import "UICollectionView+CSExtension.h"
#import "UINib+CSExtension.h"
#import "UIBarButtonItem+CSExtension.h"
#import "UICollectionViewCell+CSExtension.h"
#import "NSBundle+CSExtension.h"
#import "UIApplication+CSExtension.h"


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
