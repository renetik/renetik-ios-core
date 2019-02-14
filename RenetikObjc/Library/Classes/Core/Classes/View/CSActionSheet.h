//
// Created by Rene Dohan on 9/7/13.
// Copyright (c) 2013 creative_studio. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//

@import UIKit;

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

- (CSActionSheet *)showInView:(UIView *)view;

- (CSActionSheet *)clear;
@end
