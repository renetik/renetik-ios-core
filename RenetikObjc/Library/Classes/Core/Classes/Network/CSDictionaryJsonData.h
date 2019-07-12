//
// Created by Rene Dohan on 17/12/16.
// Copyright (c) 2016 renetik_software. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CSDictionaryJsonData;

NS_ASSUME_NONNULL_BEGIN

@interface CSDictionaryJsonData: NSObject

@property NSInteger index;
@property NSString*key;
@property (nonatomic, copy) NSString*childDataKey;
@property (readonly) NSMutableDictionary*data;
@property (readonly) BOOL isEmpty;
@property (readonly) BOOL set;

- (instancetype)loadJson :(NSString*)string;

- (instancetype)load :(NSDictionary*)dictionary;

- (instancetype)load :(CSDictionaryJsonData*)data key :(NSString*)key;

- (void)clear;

- (id)objectForKeyedSubscript :(NSString*)key;

- (id)get :(NSString*)id;

- (void)setObject :(id)thing forKeyedSubscript :(NSString*)key;

- (nullable NSString*)getString :(NSString*)key;

- (NSString*)getStringValue :(NSString*)key;

- (BOOL)isSet :(NSString*)key;

- (NSInteger)getInteger :(NSString*)key;

- (nullable NSNumber*)getIntegerNumber :(NSString*)key;

- (double)getDouble :(NSString*)key;

- (nullable NSNumber*)getDoubleNumber :(NSString*)key;

- (float)getFloat :(NSString*)key;

- (NSNumber*)getFloatNumber :(NSString*)key;

- (BOOL)getBool :(NSString*)key;

- (nullable NSMutableDictionary*)getDictionary :(NSString*)key;

- (nullable NSMutableArray*)getArray :(NSString*)key;

- (void)put :(NSString*)key :(id)value;

- (void)put :(NSMutableDictionary*)dictionary :(NSString*)key :(id)value;

- (id)JSONString;

- (nullable CSDictionaryJsonData*)getData :(NSString*)key;

- (nullable NSMutableArray<CSDictionaryJsonData*>*)createArray :(Class)type key :(NSString*)arrayKey;

- (nullable NSMutableArray<NSMutableArray<CSDictionaryJsonData*>*>*)createArrayOfArray :(Class)type key :(NSString*)arrayKey;

- (nullable NSMutableArray<CSDictionaryJsonData*>*)createArray :(Class)type dictionaryId :(NSString*)dictionaryId;
@end

NS_ASSUME_NONNULL_END
