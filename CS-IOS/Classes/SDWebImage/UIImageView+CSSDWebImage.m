//
// Created by Rene Dohan on 06/01/15.
// Copyright (c) 2015 creative_studio. All rights reserved.
//

@import UIKit;
@import SDWebImage;

#import "UIImageView+CSSDWebImage.h"
#import "CSLang.h"

@implementation UIImageView (CSSDWebImage)

- (UIImageView *)setImageNSURL:(NSURL *)url {
    return [self imageURL:url.absoluteString onSuccess:nil];
}

- (UIImageView *)imageURL:(NSString *)url onSuccess:(void (^)(UIImageView *imageView))onSuccess {
    __weak typeof(self) _self = self;
    self.sd_imageIndicator = SDWebImageProgressIndicator.barIndicator;
    [self sd_setImageWithURL:[NSURL URLWithString:url]
            placeholderImage:nil options:SDWebImageRetryFailed progress:nil
                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                       if (!error) runWith(onSuccess, _self);
                   }];
    return self;
}

- (UIImageView *)setImageURL:(NSString *)url {
    return [self imageURL:url onSuccess:nil];
}

@end
