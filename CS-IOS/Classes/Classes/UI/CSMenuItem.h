//
// Created by Rene Dohan on 26/10/15.
// Copyright (c) 2015 creative_studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CSMainController;

@interface CSMenuItem : NSObject

@property(nonatomic, copy) NSString *title;

@property(nonatomic, copy) void (^action)();

@property(nonatomic) BOOL visible;

@property(nonatomic, weak) CSMainController *controller;

@property(nonatomic) UIBarButtonSystemItem systemItem;

@property(nonatomic, strong) UIImage *image;

- (instancetype)construct:(CSMainController *)parent :(NSString *)title;

- (instancetype)construct:(CSMainController *)parent item:(UIBarButtonSystemItem)item :(void (^)())action;

- (instancetype)construct:(CSMainController *)parent :(NSString *)title :(void (^)(void))action;

- (instancetype)setOnClick:(void (^)(void))onClick;

- (void)hide;

- (void)show;

- (void)setHidden:(BOOL)hidden;

- (void)updateMenu;

- (UIBarButtonItem *)createBarButton;
@end
