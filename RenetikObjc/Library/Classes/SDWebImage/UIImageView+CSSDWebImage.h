//
// Created by Rene Dohan on 06/01/15.
// Copyright (c) 2015 creative_studio. All rights reserved.
//
@import UIKit;
@import SDWebImage;

NS_ASSUME_NONNULL_BEGIN
@interface UIImageView (CSSDWebImage)

- (instancetype)imageNSURL :(NSURL *)url onSuccess :(void (^)(UIImageView *imageView))onSuccess;

- (instancetype)imageNSURL :(NSURL *)url;

- (instancetype)imageURL :(NSString *)url onSuccess :(void (^)(UIImageView *imageView))onSuccess;

@property NSString *imageURL;
- (NSString *)imageURL UNAVAILABLE_ATTRIBUTE;

- (instancetype)imageURL :(NSString *)url;
@end
NS_ASSUME_NONNULL_END
