//
// Created by Rene Dohan on 22/05/18.
// Copyright (c) 2018 Renetik Software. All rights reserved.
//

#import "CSName.h"
#import "NSString+CSExtension.h"
#import "NSMutableArray+CSExtension.h"
#import "NSObject+CSExtension.h"
#import "CSLang.h"

@implementation CSName


+ (instancetype)create:(NSString *)name :(NSString *)id {
    return [[self.class.alloc init] construct:name id:id];
}

+ (NSMutableArray<CSName *> *)createNamesFromStrings:(NSArray<NSString *> *)strings {
    NSMutableArray<CSName *> *names = NSMutableArray.new;
    var index = 0;
    for (NSString *string in strings) [names add:[CSName create:string :nil]].index = index++;
    return names;
}

- (instancetype)construct:(NSString *)name id:(NSString *)id {
    self.name = name;
    self.id = id;
    return self;
}

- (NSString *)name {
    return [self getString:@"name"];
}

- (void)setName:(NSString *)name {
    [self put:@"name" :name];
}

- (NSString *)id {
    return [self getString:@"id"];
}

- (void)setId:(NSString *)id {
    [self put:@"id" :id];
}

- (NSString *)description {
    return self.name;
}

- (BOOL)isEqual:(id)object {
    BOOL isEqual = [self.description isEqualToString:[object description]];
    if (!isEqual)return [super isEqual:object];
    return isEqual;
}


+ (CSName *)findById:(NSArray<CSName *> *)names :(NSString *)nameId {
    for (CSName *name  in names) if ([name.id equals:nameId]) return name;
    return nil;
}

+ (CSName *)findByName:(NSArray<CSName *> *)names :(NSString *)nameToFind {
    for (CSName *name  in names) if ([name.name equals:nameToFind]) return name;
    return nil;
}

@end