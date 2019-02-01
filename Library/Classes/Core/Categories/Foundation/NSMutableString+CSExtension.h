//
// Created by Rene Dohan on 15/08/17.
// Copyright (c) 2017 renetik_software. All rights reserved.
//

@import Foundation;

@interface NSMutableString (CSExtension)

- (instancetype)append:(NSString *)string;

- (instancetype)appendStrings:(NSArray<NSString *> *)strings;

- (instancetype)deleteLast:(NSInteger)length;
@end
