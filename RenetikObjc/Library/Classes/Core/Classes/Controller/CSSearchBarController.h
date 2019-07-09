//
// Created by Rene Dohan on 21/01/15.
// Copyright (c) 2015 creative_studio. All rights reserved.
//

@import UIKit;

#import "CSChildViewLessController.h"
@class CSMainController;

NS_ASSUME_NONNULL_BEGIN
@interface CSSearchBarController: CSChildViewLessController <UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar*bar;
@property (nonatomic, copy, readonly) NSString*text;

- (instancetype)construct:(CSMainController*)parent :(UISearchBar*)bar :(void (^)(NSString*))onTextDidChange;

- (instancetype)construct:(CSMainController*)parent :(void (^)(NSString*))onTextDidChange;

@end
NS_ASSUME_NONNULL_END
