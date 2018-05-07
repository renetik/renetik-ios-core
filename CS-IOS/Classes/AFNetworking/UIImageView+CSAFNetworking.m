//
// Created by inno on 2/4/13.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import "UIImageView+AFNetworking.h"

@implementation UIImageView (CSAFNetworking)

- (void)setImageWithURL:(NSURL *)url {
    [self setImageWithURL:url placeholderImage:nil];
}

- (void)reloadImageWithURL:(NSURL *)url {
    if (!url)return;
    NSMutableURLRequest *request = [self createImageRequest:url];
    request.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    [self setImageWithURLRequest:request placeholderImage:nil success:nil failure:nil];
}

- (void)setImageWithURL:(NSURL *)url
       placeholderImage:(UIImage *)placeholderImage {
    [self setImageWithURL:url placeholderImage:placeholderImage success:nil];
}

- (void)setImageWithURL:(NSURL *)url
       placeholderImage:(UIImage *)placeholderImage
                success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image))success {
    if (!url)return;
    [self setImageWithURLRequest:[self createImageRequest:url] placeholderImage:placeholderImage success:success failure:nil];
}

- (NSMutableURLRequest *)createImageRequest:(NSURL *)url {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPShouldHandleCookies:YES];
    [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];
    return request;
}

@end