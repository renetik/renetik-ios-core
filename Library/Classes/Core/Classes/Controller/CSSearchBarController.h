//
// Created by Rene Dohan on 21/01/15.
// Copyright (c) 2015 creative_studio. All rights reserved.
//

@import UIKit;

#import "CSChildViewLessController.h"

@class CSMainController;

@interface CSSearchBarController : CSChildViewLessController <UISearchBarDelegate>

@property(nonatomic, strong) UISearchBar *searchBar;

- (instancetype)construct:(CSMainController *)parent :(UISearchBar *)bar :(void (^)(NSString *))onTextDidChange;

- (instancetype)construct:(CSMainController *)parent :(void (^)(NSString *))onTextDidChange;

- (NSString *)text;
@end
