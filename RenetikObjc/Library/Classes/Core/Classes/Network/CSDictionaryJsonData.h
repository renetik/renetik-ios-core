//
// Created by Rene Dohan on 17/12/16.
// Copyright (c) 2016 renetik_software. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CSDictionaryJsonData;

NS_ASSUME_NONNULL_BEGIN

@interface CSDictionaryJsonData : NSObject

@property NSInteger index;
@property NSString *key;
@property(nonatomic, copy) NSString *childDataKey;
@property(nonatomic, readonly) NSMutableDictionary *data;

- (instancetype)loadJson:(NSString *)string;

- (instancetype)load:(NSDictionary *)dictionary;

- (instancetype)load:(CSDictionaryJsonData *)data key:(NSString *)key;

- (BOOL)isEmpty;

- (BOOL)set;

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

- (void)put:(NSString *)key :(id)value;

- (void)put:(NSMutableDictionary *)dictionary :(NSString *)key :(id)value;

- (id)JSONString;

- (CSDictionaryJsonData *)getData:(NSString *)key;

- (NSMutableArray<CSDictionaryJsonData *> *)createArray:(Class)type key:(NSString *)arrayKey;

- (NSMutableArray<NSMutableArray<CSDictionaryJsonData *> *> *)createArrayOfArray:(Class)type key:(NSString *)arrayKey;

- (NSMutableArray<CSDictionaryJsonData *> *)createArray:(Class)type dictionaryId:(NSString *)dictionaryId;
@end

NS_ASSUME_NONNULL_END
