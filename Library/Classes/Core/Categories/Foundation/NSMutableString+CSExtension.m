//
// Created by Rene Dohan on 15/08/17.
// Copyright (c) 2017 renetik_software. All rights reserved.
//

#import "NSMutableString+CSExtension.h"


@implementation NSMutableString (CSExtension)

- (instancetype)appendStrings:(NSArray<NSString *> *)strings {
    for (NSString *string in strings) [self appendString:string];
    return self;
}

- (instancetype)append:(NSString *)string {
    [self appendString:string];
    return self;
}

- (instancetype)deleteLast:(NSInteger)length {
    if (self.length > 0) [self deleteCharactersInRange:NSMakeRange(self.length - length, (NSUInteger) length)];
    return self;
}

@end