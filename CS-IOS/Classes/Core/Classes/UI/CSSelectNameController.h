//
// Created by Rene Dohan on 26/05/18.
// Copyright (c) 2018 Renetik Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSMainController.h"
#import "CSName.h"

@interface CSSelectNameController : CSMainController

@property(nonatomic, strong) UITableView *table;
@property(nonatomic, strong) UISearchBar *search;
@property(nonatomic, strong) CSName *selectedRow;

- (instancetype)constructByNames:(NSArray<CSName *> *)names :(void (^)(CSName *))onSelected;

- (instancetype)constructByNames:(NSArray<CSName *> *)names :(void (^)(CSName *))onSelected :(NSString *)clearTitle;

- (instancetype)constructByStrings:(NSArray<NSString *> *)strings :(void (^)(NSNumber *))onSelected :(NSString *)clearTitle;

- (instancetype)constructByNames:(NSArray<CSName *> *)names :(void (^)(CSName *))onSelected :(void (^)(CSName *))onDelete :(NSString *)deleteTitle;

- (instancetype)setData:(NSArray<CSName *> *)names;


@end