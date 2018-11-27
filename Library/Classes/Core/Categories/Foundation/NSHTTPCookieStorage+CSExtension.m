//
// Created by Rene Dohan on 19/11/13.
// Copyright (c) 2013 creative_studio. All rights reserved.
//


#import "NSHTTPCookieStorage+CSExtension.h"


@implementation NSHTTPCookieStorage (CSExtension)

+ (void)deleteAllCookies {
    for (NSHTTPCookie *cookie in NSHTTPCookieStorage.sharedHTTPCookieStorage.cookies)
        [NSHTTPCookieStorage.sharedHTTPCookieStorage deleteCookie:cookie];
}

@end