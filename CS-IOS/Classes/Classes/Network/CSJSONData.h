//
// Created by Rene Dohan on 17/12/16.
// Copyright (c) 2016 renetik_software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSServerDataProtocol.h"

@interface CSJSONData : NSObject

@property NSUInteger index;
@property NSString *key;
@property(nonatomic, copy) NSString *childDataKey;
@property(nonatomic, readonly) NSMutableDictionary *data;

- (instancetype)initWithObject:(NSMutableDictionary *)dictionary;

- (instancetype)load:(NSMutableDictionary *)data;

- (BOOL)isEmpty;

- (id)proxyForJson;

- (void)clear;

- (id)objectForKeyedSubscript:(NSString *)key;

- (id)get:(NSString *)id;

- (void)setObject:(id)thing forKeyedSubscript:(NSString *)key;

- (NSString *)getString:(NSString *)key;

- (BOOL)isSet:(NSString *)key;

- (NSInteger)getInteger:(NSString *)key;

- (NSNumber *)getIntegerNumber:(NSString *)key;

- (double)getDouble:(NSString *)key;

- (NSNumber *)getDoubleNumber:(NSString *)key;

- (BOOL)getBool:(NSString *)key;

- (NSMutableDictionary *)getDictionary:(NSString *)key;

- (NSMutableArray *)getArray:(NSString *)key;

- (id)get:(NSDictionary *)dictionary :(NSString *)key;

- (void)put:(NSString *)key :(id)value;

- (void)put:(NSMutableDictionary *)dictionary :(NSString *)key :(id)value;

- (instancetype)load:(CSJSONData *)data key:(NSString *)id1;

- (id)JSONString;

- (CSJSONData *)getData:(NSString *)key;

- (NSMutableArray *)sort:(NSMutableArray<CSJSONData *> *)array :(NSComparator)comparator;

- (NSArray *)reIndex:(NSArray<CSJSONData *> *)array;

- (NSMutableArray *)createArray:(Class)type key:(NSString *)arrayKey;

- (NSMutableArray *)createArrayOfArray:(Class)type key:(NSString *)arrayKey;

- (NSMutableArray *)createArrayOfArray:(Class)type :(NSArray<NSArray<NSDictionary *> *> *)jsonArray;

- (NSMutableArray *)createArray:(Class)type :(NSArray<NSMutableDictionary *> *)arrayOfDictionaries;

- (NSMutableArray *)createArray:(Class)type dictionaryId:(NSString *)dictionaryId;

- (NSMutableArray *)createArray:(Class)type dictionaryOfDictionaries:(NSDictionary<NSString *, NSMutableDictionary *> *)dictionaryOfDictionaries;
@end
