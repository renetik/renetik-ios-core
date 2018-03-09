//
// Created by Rene Dohan on 02/12/14.
// Copyright (c) 2014 creative_studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIApplication (CSExtension)
+ (UIWindow *)window;

+ (void)resignFirstResponder;

- (UIApplication *)openNSURL:(NSURL *)url;

- (UIApplication *)openURLString:(NSString *)url;
@end