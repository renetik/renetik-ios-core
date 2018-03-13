//
// Created by Rene Dohan on 06/01/15.
// Copyright (c) 2015 creative_studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+CSSDWebImage.h"
#import <SDWebImage/UIView+WebCache.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "CSLang.h"

@implementation UIImageView (CSSDWebImage)

- (UIImageView *)setCSImageNSURL:(NSURL *)url {
    return [self setCSImageURL:url.absoluteString onSuccess:nil];
}

- (UIImageView *)setCSImageURL:(NSString *)url onSuccess:(void (^)(UIImageView *imageView))onSuccess {
    __weak typeof(self) _self = self;
    [self sd_setShowActivityIndicatorView:YES];
    [self sd_setIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self sd_setImageWithURL:[NSURL URLWithString:url]
            placeholderImage:nil options:SDWebImageRetryFailed progress:nil
                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                       if (!error) runWith(onSuccess, _self);
                   }];
    return self;
}

- (UIImageView *)setCSImageURL:(NSString *)url {
    [self setCSImageURL:url onSuccess:nil];
    return self;
}

@end