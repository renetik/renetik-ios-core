//
// Created by Rene Dohan on 26/10/15.
// Copyright (c) 2015 creative_studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CSMainController;

@interface CSMenuItem : NSObject

@property(nonatomic, copy) NSString *title;

@property(nonatomic, assign) NSUInteger index;

@property(nonatomic, copy) void (^action)(CSMenuItem *);

@property(nonatomic) BOOL visible;

@property(nonatomic, weak) CSMainController *controller;

@property(nonatomic) UIBarButtonSystemItem systemItem;

@property(nonatomic, strong) UIImage *image;

@property(nonatomic) BOOL closeMenu;

- (instancetype)construct:(CSMainController *)parent :(NSString *)title;

- (instancetype)construct:(CSMainController *)parent item:(UIBarButtonSystemItem)item :(void (^)(CSMenuItem *))action;

- (instancetype)construct:(CSMainController *)parent :(NSString *)title :(void (^)(CSMenuItem *))action;

- (instancetype)setOnClick:(void (^)(CSMenuItem *))onClick;

- (void)hide;

- (void)show;

- (void)setHidden:(BOOL)hidden;

- (void)updateMenu;

- (UIBarButtonItem *)createBarButton;

- (instancetype)closeMenu:(BOOL)close;
@end
