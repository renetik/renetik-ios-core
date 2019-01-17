//
// Created by Rene Dohan on 26/05/18.
// Copyright (c) 2018 Renetik Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSMainController.h"
#import "CSName.h"
@protocol CSListData;

NS_ASSUME_NONNULL_BEGIN
@interface CSSelectNameController : CSMainController

@property(nonatomic, strong) UITableView *table;
@property(nonatomic, strong) UISearchBar *search;
@property(nonatomic, strong) CSName *selectedRow;
@property(nonatomic, strong) UIColor *primaryColor;
@property(nonatomic, strong) UIColor *secondaryColor;
@property(nonatomic, strong) UIColor *backgroundColor;

- (instancetype)constructByData:(NSObject <CSListData> *)data :(void (^)(CSName *))onSelected;

- (instancetype)constructByData:(NSObject <CSListData> *)names :(void (^)(CSName *))onSelected
							   :(NSString *)deleteTitle :(CSResponse * (^)(CSName *))onDelete;

- (instancetype)constructByNames:(NSArray<CSName *> *)names :(void (^)(CSName *))onSelected;

- (instancetype)constructByNames:(NSArray<CSName *> *)names :(void (^)(CSName *))onSelected :(NSString *)clearTitle;

- (instancetype)constructByStrings:(NSArray<NSString *> *)strings :(void (^)(NSNumber *))onSelected :(NSString *)clearTitle;

- (instancetype)constructByNames:(NSArray<CSName *> *)names :(void (^)(CSName *))onSelected
								:(NSString *)deleteTitle :(CSResponse * (^)(CSName *))onDelete ;

- (instancetype)setData:(NSArray<CSName *> *)names;

@end
NS_ASSUME_NONNULL_END
