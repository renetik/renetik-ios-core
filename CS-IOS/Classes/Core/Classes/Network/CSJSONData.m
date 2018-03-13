//
// Created by Rene Dohan on 17/12/16.
// Copyright (c) 2016 renetik_software. All rights reserved.
//

#import "CSJSONData.h"
#import "CSLang.h"
#import "NSMutableArray+CSExtension.h"
#import "NSObject+CSExtension.h"
#import "NSString+CSExtension.h"
#import "NSException+CSExtension.h"
#import "NSDictionary+CSSBJson.h"
#import "CSCocoaLumberjack.h"

@implementation CSJSONData

- (instancetype)initWithObject:(NSMutableDictionary *)dictionary {
    if (self = [super init]) {
        _data = dictionary;
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        _data = NSMutableDictionary.new;
    }
    return self;
}

- (instancetype)load:(NSMutableDictionary *)data {
    if (data && [data isKindOfClass:NSMutableDictionary.class]) {
        _data = data;
        return self;
    } else return nil;
}

- (instancetype)load:(CSJSONData *)data key:(NSString *)id {
    return [self load:[data getDictionary:id]];
}

- (id)objectForKeyedSubscript:(NSString *)key {
    return [self get:key];
}

- (id)get:(NSString *)key {
    NSDictionary *data = _childDataKey ? _data[_childDataKey] : _data;
    return [self get:data :key];
}

- (void)put:(NSString *)key :(id)value {
    NSMutableDictionary *data = _childDataKey ? _data[_childDataKey] : _data;
    if (![data isKindOfClass:NSMutableDictionary.class])
        @throw [NSException exceptionWithName:@"Expected NSMutableDictionary"];
    data[key] = value ? value : NSNull.null;
}

- (void)setObject:(id)thing forKeyedSubscript:(NSString *)key {
    [self put:key :thing];
}

- (NSString *)getString:(NSString *)key {
    id value = [self get:key];
    if (value) return stringify(value);
    return nil;
}

- (BOOL)isSet:(NSString *)key {
    return [self get:key] != nil;
}

- (NSInteger)getInteger:(NSString *)key {
    return [self getString:key].integerValue;
}

- (NSNumber *)getIntegerNumber:(NSString *)key {
    if (![self isSet:key]) return nil;
    return @([self getInteger:key]);
}

- (double)getDouble:(NSString *)key {
    return [self getString:key].doubleValue;
}

- (NSNumber *)getDoubleNumber:(NSString *)key {
    if (![self isSet:key]) return nil;
    return @([self getDouble:key]);
}

- (BOOL)getBool:(NSString *)key {
    return [self getString:key].boolValue;
}

- (NSMutableDictionary *)getDictionary:(NSString *)key {
    id value = [self get:key];
    if (!value || [value isKindOfClass:NSMutableDictionary.class]) return value;
    return nil;
}

- (NSMutableArray *)getArray:(NSString *)key {
    id value = [self get:key];
    if (!value || [value isKindOfClass:NSMutableArray.class]) return value;
    return nil;
}

- (id)get:(NSDictionary *)dictionary :(NSString *)key {
    if (![dictionary isKindOfClass:NSMutableDictionary.class]) return nil;
    id value = dictionary[key];
    if (value == nil) info([@"Key " add:key :@" not found in " :self.className]);
    if (value == NSNull.null) return nil;
    return value;
}

- (void)put:(NSMutableDictionary *)dictionary :(NSString *)key :(id)value {
    if (value == nil) dictionary[key] = NSNull.null;
    else dictionary[key] = value;
}

- (NSString *)description {
    return _data.description;
}

- (id)proxyForJson {
    return _data;
}

- (void)clear {
    _data = NSMutableDictionary.new;
}

- (BOOL)isEmpty {
    return _data.count == 0;
}

- (id)JSONString {
    return _data.JSONString;
}

- (CSJSONData *)getData:(NSString *)key {
    var dictionary = [self getDictionary:key];
    return dictionary ? [CSJSONData.alloc initWithObject:dictionary] : nil;
}

- (NSMutableArray *)sort:(NSMutableArray<CSJSONData *> *)array :(NSComparator)comparator {
    return [NSMutableArray.new construct:[self reIndex:[array sortedArrayUsingComparator:comparator]]];
}

- (NSArray *)reIndex:(NSArray<CSJSONData *> *)array {
    uint index = 0;
    for (CSJSONData *data in array) data.index = index++;
    return array;
}

- (NSMutableArray *)createArray:(Class)type key:(NSString *)arrayKey {
    return [self createArray:type :[self getArray:arrayKey]];
}

- (NSMutableArray *)createArrayOfArray:(Class)type key:(NSString *)arrayKey {
    return [self createArrayOfArray:type :[self getArray:arrayKey]];
}

- (NSMutableArray *)createArrayOfArray:(Class)type :(NSArray<NSArray<NSDictionary *> *> *)jsonArray {
    if (!jsonArray) return nil;
    NSMutableArray<NSMutableArray<CSJSONData *> *> *dataArray = NSMutableArray.new;
    for (NSArray<NSMutableDictionary *> *arrayOfDictionaries in jsonArray)
        [dataArray add:[self createArray:type :arrayOfDictionaries]];
    return dataArray;
}

- (NSMutableArray *)createArray:(Class)type :(NSArray<NSMutableDictionary *> *)arrayOfDictionaries {
    if (!arrayOfDictionaries) return nil;
    NSMutableArray<CSJSONData *> *array = NSMutableArray.new;
    uint count = 0;
    for (NSMutableDictionary *value in arrayOfDictionaries)
        [array add:[[type.new construct] load:value]].index = count++;
    return array;
}

- (NSMutableArray *)createArray:(Class)type dictionaryId:(NSString *)dictionaryId {
    return [self createArray:type dictionaryOfDictionaries:[self getDictionary:dictionaryId]];
}

- (NSMutableArray *)createArray:(Class)type dictionaryOfDictionaries:(NSDictionary<NSString *, NSMutableDictionary *> *)dictionaryOfDictionaries {
    if (!dictionaryOfDictionaries) return nil;
    NSMutableArray<CSJSONData *> *array = NSMutableArray.new;
    uint count = 0;
    for (NSString *key in dictionaryOfDictionaries) {
        CSJSONData *data = [array add:[[type.new construct] load:dictionaryOfDictionaries[key]]];
        data.key = key;
        data.index = count++;
    }
    return array;
}
@end
