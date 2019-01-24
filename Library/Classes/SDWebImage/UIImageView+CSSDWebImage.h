//
// Created by Rene Dohan on 06/01/15.
// Copyright (c) 2015 creative_studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (CSSDWebImage)

- (instancetype)imageNSURL:(NSURL *)url;

- (instancetype)imageURL:(NSString *)url onSuccess:(void (^)(UIImageView *imageView))onSuccess;

- (void)setImageURL:(NSString *)url;

- (instancetype)imageURL:(NSString *)url;
@end