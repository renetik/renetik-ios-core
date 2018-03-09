//
// Created by Rene Dohan on 02/09/17.
// Copyright (c) 2017 renetik_software. All rights reserved.
//

#import "CSNetwork.h"
#import <SystemConfiguration/CaptiveNetwork.h>


@implementation CSNetwork

+ (NSString *)getSSID {
    CFArrayRef interFaceNames = CNCopySupportedInterfaces();
    CFDictionaryRef networkInfo = CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(interFaceNames, 0));
    if (networkInfo) return (__bridge_transfer id) CFDictionaryGetValue(networkInfo, kCNNetworkInfoKeySSID);
    return @"";
}

@end