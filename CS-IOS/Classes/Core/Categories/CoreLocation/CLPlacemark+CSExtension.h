//
// Created by Rene Dohan on 14/06/17.
// Copyright (c) 2017 renetik_software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface CLPlacemark (CSExtension)
- (NSString *)street;

- (NSString *)state;

- (NSString *)city;

- (NSString *)zip;

- (NSString *)countryCode;
@end