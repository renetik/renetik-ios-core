//
// Created by Rene Dohan on 13/01/15.
// Copyright (c) 2015 creative_studio. All rights reserved.
//

@import UIKit;

@class ManagementFindUserSettingsController;

@interface UIBarButtonItem (CSExtension)

+ (UIBarButtonItem *)createSoloTitle:(NSString *)title;

+ (UIBarButtonItem *)createWithTitle:(NSString *)title :(UIBarButtonItemStyle)style :(id)target :(SEL)action;

+ (UIBarButtonItem *)createWithItem:(UIBarButtonSystemItem)item :(id)target :(SEL)action;

+ (UIBarButtonItem *)createWithItem:(UIBarButtonSystemItem)item;

+ (UIBarButtonItem *)createFlexSpaceItem;

+ (UIImage *)imageFromSystemBarButton:(UIBarButtonSystemItem)systemItem :(UIColor *)color;

- (void)setTarget:(id)target forAction:(SEL)action;

@end
