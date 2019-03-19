//
// Created by Rene Dohan on 02/12/14.
// Copyright (c) 2014 creative_studio. All rights reserved.
//

#import "UIApplication+CSExtension.h"
#import "UIDevice+CSExtension.h"

@implementation UIApplication (CSExtension)

+ (UIWindow *)window {
    return [UIApplication.sharedApplication.windows lastObject];
}

+ (void)resignFirstResponder {
    [UIApplication.sharedApplication sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

- (UIApplication *)openNSURL:(NSURL *)url {
    if (UIDevice.isIOS10) [self openURL:url options:@{} completionHandler:nil];
    else [self openURL:url];
    return self;
}

- (UIApplication *)openURLString:(NSString *)url {
    [self openNSURL:[NSURL URLWithString:url]];
    return self;
}

+ (CGFloat)statusBarHeight {
    CGSize statusBarSize = [[UIApplication sharedApplication] statusBarFrame].size;
    return MIN(statusBarSize.width, statusBarSize.height);
}

@end
