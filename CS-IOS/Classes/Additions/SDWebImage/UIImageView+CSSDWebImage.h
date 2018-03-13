//
// Created by Rene Dohan on 06/01/15.
// Copyright (c) 2015 creative_studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (CSSDWebImage)

- (UIImageView *)setCSImageNSURL:(NSURL *)url;

- (UIImageView *)setCSImageURL:(NSString *)url onSuccess:(void (^)(UIImageView *imageView))onSuccess;

- (UIImageView *)setCSImageURL:(NSString *)url;

@end