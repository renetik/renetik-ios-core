//
// Created by Rene Dohan on 19/02/18.
// Copyright (c) 2018 renetik_software. All rights reserved.
//
@import UIKit;

@interface UIScreen (CSExtension)

+ (UIInterfaceOrientation)orientation;

+ (BOOL)isPortrait;

+ (BOOL)isLandscape;

+ (CGFloat)width;

+ (CGFloat)height;

@end
