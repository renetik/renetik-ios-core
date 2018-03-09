//
// Created by Rene Dohan on 15/10/14.
// Copyright (c) 2014 Rene Dohan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSViewController.h"
#import "CSChildViewLessController.h"

@interface CSModalBackgroundDismissController : CSChildViewLessController <UIGestureRecognizerDelegate>

- (instancetype)construct:(CSMainController *)parent;

@end