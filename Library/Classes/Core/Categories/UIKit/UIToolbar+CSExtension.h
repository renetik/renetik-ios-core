//
// Created by Rene Dohan on 30/12/14.
// Copyright (c) 2014 creative_studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIToolbar (CSExtension)
- (void)changeText:(UIBarButtonItem *)item :(NSString *)title;

+ (CGFloat)HEIGHT;

- (void)changeTextAt:(NSInteger)itemIndex :(NSString *)title;

- (void)changeItem:(UIBarButtonItem *)item :(UIBarButtonSystemItem)systemItem;

- (void)changeItemAt:(NSInteger)itemIndex :(UIBarButtonSystemItem)systemItem;

- (UIBarButtonItem *)replaceItem:(UIBarButtonItem *)replacedItem by:(UIBarButtonItem *)replacingItem;

- (UIBarButtonItem *)setItem:(UIBarButtonItem *)buttonItem atIndex:(NSUInteger)index;

- (UIToolbar *)insertItem:(UIBarButtonItem *)item atIndex:(NSUInteger)index;

- (UIBarButtonItem *)setItem:(UIBarButtonItem *)buttonItem atIndex:(NSUInteger)index animated:(BOOL)animated;

- (void)insertItem:(UIBarButtonItem *)item atIndex:(NSUInteger)index animated:(BOOL)animated;

@end