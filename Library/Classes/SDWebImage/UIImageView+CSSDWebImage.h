//
// Created by Rene Dohan on 06/01/15.
// Copyright (c) 2015 creative_studio. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UIImageView (CSSDWebImage)

- (instancetype)imageNSURL:(NSURL *)url;

- (instancetype)imageURL:(NSString *)url onSuccess:(void (^)(UIImageView *imageView))onSuccess;

- (void)setImageURL:(NSString *)url;

- (instancetype)imageURL:(NSString *)url;
@end
NS_ASSUME_NONNULL_END
