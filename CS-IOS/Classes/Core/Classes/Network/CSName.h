//
// Created by Rene Dohan on 22/05/18.
// Copyright (c) 2018 Renetik Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSJSONData.h"

@interface CSName : CSJSONData

@property(nonatomic, assign) NSString *name;
@property(nonatomic, assign) NSString *id;

+ (CSName *)findById:(NSArray<CSName *> *)names :(NSString *)nameId;

+ (CSName *)findByName:(NSArray<CSName *> *)names :(NSString *)nameToFind;

+ (NSArray<NSString *> *)asStrings:(NSArray<CSName *> *)names;

- (instancetype)construct:(NSString *)name :(NSString *)id;

- (instancetype)construct:(NSString *)name;

+ (instancetype)create:(NSString *)name :(NSString *)id;

@end