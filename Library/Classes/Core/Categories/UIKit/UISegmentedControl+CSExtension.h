//
// Created by Rene Dohan on 26/05/18.
// Copyright (c) 2018 Renetik Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UISegmentedControl (CSExtension)
- (NSString *)selectedTitle;

+ (int)DEFAULT_HEIGHT;

- (NSInteger)selectedIndex;
@end