//
// Created by Rene Dohan on 9/7/13.
// Copyright (c) 2013 creative_studio. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
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


@interface CSActionSheet : NSObject <UIActionSheetDelegate>

@property(nonatomic, readonly) UIActionSheet *sheet;

@property(nonatomic, readonly) BOOL visible;

- (instancetype)title:(NSString *)title;

- (instancetype)cancel:(NSString *)cancel;

- (instancetype)destructive:(NSString *)title :(void (^)(void))onDestructive;

- (instancetype)onDestructive:(void (^)(void))onDestructive;

- (instancetype)actions:(NSArray *)titles :(NSArray *)actions;

- (instancetype)actions:(NSArray *)titles for:(void (^)(NSInteger))action;

- (instancetype)addAction:(NSString *)title :(void (^)(void))action;

- (instancetype)showFromBarItem:(UIBarButtonItem *)item;

- (instancetype)showFromRect:(CGRect)rect inView:(UIView *)view;

- (void)hide;

- (CSActionSheet *)showFromCell:(UITableViewCell *)cell;

- (CSActionSheet *)showInView:(UIView *)view;

- (CSActionSheet *)clear;
@end
