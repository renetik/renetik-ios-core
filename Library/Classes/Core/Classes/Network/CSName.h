//
// Created by Rene Dohan on 22/05/18.
// Copyright (c) 2018 Renetik Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSJSONData.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSName : CSJSONData

+ (instancetype)create:(NSString *)name :(NSString *)id;

- (NSString *)name;

- (NSString *)id;

- (void)setName:(NSString *)name;

- (void)setId:(NSString *)id;

- (instancetype)construct:(NSString *)name id:(NSString *)id;

+ (CSName *)findById:(NSArray<CSName *> *)names :(NSString *)nameId;

+ (CSName *)findByName:(NSArray<CSName *> *)names :(NSString *)nameToFind;

+ (NSMutableArray<CSName *> *)createNamesFromStrings:(NSArray<NSString *> *)strings;

@end

NS_ASSUME_NONNULL_END
