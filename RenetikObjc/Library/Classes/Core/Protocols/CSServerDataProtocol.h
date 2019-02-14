//
// Created by Rene Dohan on 6/4/17.
// Copyright (c) 2017 renetik_software. All rights reserved.
//
@import Foundation;

@protocol CSServerDataProtocol <NSObject>

- (instancetype)initWithDictionary:(NSMutableDictionary *)dictionary;

- (instancetype)load:(NSMutableDictionary *)data;

@property NSUInteger index;

@property(nonatomic, readonly) NSMutableDictionary *data;

- (BOOL)success;

- (NSString *)error;

- (BOOL)isEmpty;

- (id)proxyForJson;

- (void)clear;

- (id)get:(NSString *)id;

- (NSString *)getString:(NSString *)key;

- (NSInteger)getInteger:(NSString *)key;

- (double)getDouble:(NSString *)key;

- (BOOL)getBOOL:(NSString *)key;

- (id)get:(NSDictionary *)dictionary :(NSString *)key;

- (void)put:(NSString *)key :(id)value;

- (void)put:(NSMutableDictionary *)dictionary :(NSString *)key :(id)value;

- (id)objectForKeyedSubscript:(NSString *)key;

- (void)setObject:(id)thing forKeyedSubscript:(NSString *)key;

- (id)JSONString;

- (NSMutableArray *)createList:(NSString *)id :(Class)clazz;

- (id <CSServerDataProtocol> *)getData:(NSString *)key;

@end
