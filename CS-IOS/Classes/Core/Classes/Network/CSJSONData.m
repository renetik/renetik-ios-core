//
// Created by Rene Dohan on 17/12/16.
// Copyright (c) 2016 renetik_software. All rights reserved.
//

#import "CSCocoaLumberjack.h"
#import "CSJSONData.h"
#import "CSLang.h"
#import "NSDictionary+CSExtension.h"
#import "NSException+CSExtension.h"
#import "NSMutableArray+CSExtension.h"
#import "NSMutableDictionary+CSExtension.h"
#import "NSObject+CSExtension.h"
#import "NSString+CSExtension.h"
#import "CSName.h"

@implementation CSJSONData

+ (NSArray *)reIndex:(NSArray<CSJSONData *> *)array {
    var index = 0;
    for (CSJSONData *data in array)data.index = index++;
    return array;
}

- (instancetype)init {
    if (self == super.init) _data = NSMutableDictionary.new;
    return self;
}

- (instancetype)construct:(NSDictionary *)value {
    if ([value isKindOfClass:NSMutableDictionary.class])
        _data = (NSMutableDictionary *) value;
    else if ([value isKindOfClass:NSDictionary.class])
        _data = [NSMutableDictionary.new construct:value];
    else {
        errorf(@"value %@ is not dictionary", value);
        _data = NSMutableDictionary.new;
    }
    return self;
}

- (instancetype)construct:(CSJSONData *)data key:(NSString *)id {
    return [self construct:[data getDictionary:id]];
}

- (instancetype)constructByString:(NSString *)value {
    [self construct];
    id jsonValue = value.jsonValue;
    if ([jsonValue isKindOfClass:NSDictionary.class])
        [self construct:jsonValue];
    return self;
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
        [NSException exceptionWithName:@"Expected NSMutableDictionary"];
    data[key] = value ? value : NSNull.null;
}

- (void)setObject:(id)thing forKeyedSubscript:(NSString *)key {
    [self put:key :thing];
}

- (NSString *)getString:(NSString *)key {
    id value = [self get:key];
    if (value)
        return stringify(value);
    return nil;
}

- (BOOL)isSet:(NSString *)key {
    return [self get:key] != nil;
}

- (NSInteger)getInteger:(NSString *)key {
    return [self getString:key].integerValue;
}

- (NSNumber *)getIntegerNumber:(NSString *)key {
    if (![self isSet:key])
        return nil;
    return @([self getInteger:key]);
}

- (double)getDouble:(NSString *)key {
    return [self getString:key].doubleValue;
}

- (NSNumber *)getDoubleNumber:(NSString *)key {
    if (![self isSet:key])
        return nil;
    return @([self getDouble:key]);
}

- (BOOL)getBool:(NSString *)key {
    return [self getString:key].boolValue;
}

- (NSMutableDictionary *)getDictionary:(NSString *)key {
    id value = [self get:key];
    if (!value || [value isKindOfClass:NSMutableDictionary.class])
        return value;
    return nil;
}

- (NSMutableArray *)getArray:(NSString *)key {
    id value = [self get:key];
    if (!value || [value isKindOfClass:NSMutableArray.class])
        return value;
    return nil;
}

- (id)get:(NSDictionary *)dictionary :(NSString *)key {
    if (![dictionary isKindOfClass:NSMutableDictionary.class])
        return nil;
    id value = dictionary[key];
    if (value == nil) NSLog(@"Key %@ not found in %@", key, self.className);
    if (value == NSNull.null) return nil;
    return value;
}

- (void)put:(NSMutableDictionary *)dictionary :(NSString *)key
        :(id)value {
    if (value == nil)
        dictionary[key] = NSNull.null;
    else
        dictionary[key] = value;
}

- (NSString *)description {
    return _data.description;
}

- (void)clear {
    _data = NSMutableDictionary.new;
}

- (BOOL)isEmpty {
    return !_data || _data.count == 0;
}

- (BOOL)set {
    return !self.isEmpty;
}

- (id)JSONString {
    return _data.jsonString;
}

- (CSJSONData *)getData:(NSString *)key {
    var dictionary = [self getDictionary:key];
    return dictionary ? [CSJSONData.new construct:dictionary] : nil;
}

- (NSMutableArray *)sort:(NSMutableArray<CSJSONData *> *)array :(NSComparator)comparator {
    return [NSMutableArray.new construct:[CSName reIndex:[array sortedArrayUsingComparator:comparator]]];
}

- (NSMutableArray *)createArray:(Class)type key:(NSString *)arrayKey {
    return [self createArray:type :[self getArray:arrayKey]];
}

- (NSMutableArray *)createArrayOfArray:(Class)type key:(NSString *)arrayKey {
    return [self createArrayOfArray:type :[self getArray:arrayKey]];
}

- (NSMutableArray *)createArrayOfArray:(Class)type :(NSArray<NSArray<NSDictionary *> *> *)jsonArray {
    if (!jsonArray)
        return nil;
    NSMutableArray<NSMutableArray<CSJSONData *> *> *dataArray = NSMutableArray.new;
    for (NSArray<NSMutableDictionary *> *arrayOfDictionaries in jsonArray)
        [dataArray add:[self createArray:type :arrayOfDictionaries]];
    return dataArray;
}

- (NSMutableArray *)createArray:(Class)type :(NSArray<NSMutableDictionary *> *)arrayOfDictionaries {
    if (!arrayOfDictionaries)
        return nil;
    NSMutableArray<CSJSONData *> *array = NSMutableArray.new;
    uint count = 0;
    for (NSMutableDictionary *value in arrayOfDictionaries)
        [array add:[type.new construct:value]].index = count++;
    return array;
}

- (NSMutableArray *)createArray:(Class)type dictionaryId:(NSString *)dictionaryId {
    return [self createArray:type dictionaryOfDictionaries:[self getDictionary:dictionaryId]];
}

- (NSMutableArray *)createArray:(Class)type
       dictionaryOfDictionaries:(NSDictionary<NSString *, NSMutableDictionary *> *)dictionaryOfDictionaries {
    if (!dictionaryOfDictionaries)
        return nil;
    NSMutableArray<CSJSONData *> *array = NSMutableArray.new;
    uint count = 0;
    for (NSString *key in dictionaryOfDictionaries) {
        CSJSONData *data = [array add:[type.new construct:dictionaryOfDictionaries[key]]];
        data.key = key;
        data.index = count++;
    }
    return array;
}

@end
