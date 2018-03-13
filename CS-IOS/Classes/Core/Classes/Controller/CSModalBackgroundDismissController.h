//
// Created by Rene Dohan on 15/10/14.
// Copyright (c) 2014 Rene Dohan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSViewController.h"
#import "CSChildViewLessController.h"

@interface CSModalBackgroundDismissController : CSChildViewLessController <UIGestureRecognizerDelegate>

- (instancetype)construct:(CSMainController *)parent;

@end