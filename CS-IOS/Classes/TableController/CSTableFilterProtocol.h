//
// Created by Rene Dohan on 10/06/17.
// Copyright (c) 2017 renetik_software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSTableController.h"

@protocol CSTableFilterProtocol <NSObject>

@optional
- (NSArray *)filterData:(NSArray *)array;

@optional
- (void)onReloadDone:(CSTableController *)tableController;

@end