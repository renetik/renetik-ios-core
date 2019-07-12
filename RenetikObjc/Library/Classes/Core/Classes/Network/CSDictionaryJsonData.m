//
// Created by Rene Dohan on 17/12/16.
// Copyright (c) 2016 renetik_software. All rights reserved.
//

#import "CSLang.h"
#import "CSCocoaLumberjack.h"
#import "CSDictionaryJsonData.h"
#import "NSDictionary+CSExtension.h"
#import "NSException+CSExtension.h"
#import "NSMutableArray+CSExtension.h"
#import "NSMutableDictionary+CSExtension.h"
#import "NSObject+CSExtension.h"
#import "NSString+CSExtension.h"
#import "CSJsonData.h"

@implementation CSDictionaryJsonData

- (instancetype)init {
    if (self == super.init) _data = NSMutableDictionary.new;
    return self;
}

- (instancetype)load :(NSDictionary *)value {
    if ([value isKindOfClass :NSMutableDictionary.class]) _data = (NSMutableDictionary *)value;
    else if ([value isKindOfClass :NSDictionary.class]) _data = [NSMutableDictionary.new construct :value];
    else {
        errorf(@"value %@ is not dictionary", value);
        _data = NSMutableDictionary.new;
    }
    return self;
}

- (instancetype)load :(CSDictionaryJsonData *)data key :(NSString *)key {
    return [self load :[data getDictionary :key]];
}

- (instancetype)loadJson :(NSString *)jsonString {
    id jsonValue = jsonString.jsonValue;
    if ([jsonValue isKindOfClass :NSDictionary.class]) [self load :jsonValue];
    else warnf(@"Data doesn't contain expoected NSDictionary %@", jsonValue);
    return self;
}

- (id)objectForKeyedSubscript :(NSString *)key {
    return [self get :key];
}

- (id)get :(NSString *)key {
    if ([_data isNotKindOfClass :NSDictionary.class]) return nil;
    NSDictionary *data = _childDataKey ? _data[_childDataKey] : _data;
    id value = data[key];
    if (value == nil) NSLog(@"Key %@ not found in %@", key, self.className);
    if (value == NSNull.null) return nil;
    return value;
}

- (void)put :(NSString *)key :(id)value {
    NSMutableDictionary *data = _childDataKey ? _data[_childDataKey] : _data;
    if (![data isKindOfClass :NSMutableDictionary.class]) [NSException exceptionWithName :@"Expected NSMutableDictionary"];
    data[key] = value ? value : NSNull.null;
}

- (void)setObject :(id)thing forKeyedSubscript :(NSString *)key {
    [self put :key :thing];
}

- (NSString *)getString :(NSString *)key {
    id value = [self get :key];
    if (value) return stringify(value);
    return nil;
}

- (NSString *)getStringValue :(NSString *)key {
    return stringify([self getString :key]);
}

- (BOOL)isSet :(NSString *)key {
    return [self get :key] != nil;
}

- (NSInteger)getInteger :(NSString *)key {
    return [self getString :key].integerValue;
}

- (NSNumber *)getIntegerNumber :(NSString *)key {
    if (![self isSet :key]) return nil;
    return @([self getInteger :key]);
}

- (double)getDouble :(NSString *)key {
    return [self getString :key].doubleValue;
}

- (NSNumber *)getDoubleNumber :(NSString *)key {
    if (![self isSet :key]) return nil;
    return @([self getDouble :key]);
}

- (float)getFloat :(NSString *)key {
	return [self getString :key].floatValue;
}

- (NSNumber *)getFloatNumber :(NSString *)key {
	if (![self isSet :key]) return nil;
	return @([self getFloat :key]);
}

- (BOOL)getBool :(NSString *)key {
    return [self getString :key].boolValue;
}

- (NSMutableDictionary *)getDictionary :(NSString *)key {
    id value = [self get :key];
    if (!value || [value isKindOfClass :NSMutableDictionary.class]) return value;
    return nil;
}

- (NSMutableArray *)getArray :(NSString *)key {
    id value = [self get :key];
    if (!value || [value isKindOfClass :NSMutableArray.class]) return value;
    return nil;
}

- (void)put :(NSMutableDictionary *)dictionary :(NSString *)key
            :(id)value {
    if (value == nil) dictionary[key] = NSNull.null;
    else dictionary[key] = value;
}

- (NSString *)description {
    return [_data description];
}

- (void)clear {
    _data = NSMutableDictionary.new;
}

- (BOOL)isEmpty {
    return !_data || [_data count] == 0;
}

- (BOOL)set {
    return !self.isEmpty;
}

- (id)JSONString {
    return [_data jsonString];
}

- (CSDictionaryJsonData *)getData :(NSString *)key {
    var dictionary = [self getDictionary :key];
    return dictionary ? [CSDictionaryJsonData.new load :dictionary] : nil;
}

- (NSMutableArray<CSDictionaryJsonData *> *)createArray :(Class)type key :(NSString *)arrayKey {
    return [CSJsonData createArray :type :[self getArray :arrayKey]];
}

- (NSMutableArray<NSMutableArray<CSDictionaryJsonData *> *> *)createArrayOfArray :(Class)type
                                                                             key :(NSString *)arrayKey {
    return [CSJsonData createArrayOfArray :type :[self getArray :arrayKey]];
}

- (NSMutableArray<CSDictionaryJsonData *> *)createArray :(Class)type dictionaryId :(NSString *)dictionaryId {
    return [CSJsonData createArray :type fromDictionary :[self getDictionary :dictionaryId]];
}

@end
