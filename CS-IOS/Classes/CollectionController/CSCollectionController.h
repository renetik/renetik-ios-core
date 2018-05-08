//
// Created by Rene Dohan on 28/10/14.
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
