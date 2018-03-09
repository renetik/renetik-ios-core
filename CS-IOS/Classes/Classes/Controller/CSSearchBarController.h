//
// Created by Rene Dohan on 21/01/15.
// Copyright (c) 2015 creative_studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSViewController.h"
#import "CSChildViewLessController.h"


@interface CSSearchBarController : CSChildViewLessController <UISearchBarDelegate>

- (instancetype)construct:(CSMainController *)parent :(UISearchBar *)bar :(void (^)(NSString *))onTextDidChange;

@end