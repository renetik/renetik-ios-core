//
// Created by Rene Dohan on 04/06/14.
// Copyright (c) 2014 creative_studio. All rights reserved.
//

@import Foundation;

@class CSEvent;

@interface CSEventRegistration : NSObject
@property(nonatomic, strong) CSEvent *event;

@property(nonatomic, copy) void (^block)(void);

- (instancetype)construct:(CSEvent *)event :(void (^)(void))pFunction;

- (void)cancel;
@end