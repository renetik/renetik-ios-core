//
// Created by Rene Dohan on 26/05/18.
// Copyright (c) 2018 Renetik Software. All rights reserved.
//
@import UIKit;

@interface UISegmentedControl (CSExtension)

+ (int)DEFAULT_HEIGHT;

@property(readonly) NSString *selectedTitle;

@property(readonly) NSInteger selectedIndex;

@end