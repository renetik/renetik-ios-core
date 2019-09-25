//
// Created by Rene Dohan on 04/06/14.
// Copyright (c) 2014 creative_studio. All rights reserved.
//

@import Foundation;

#import "CSEvent.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSEventRegistration : NSObject

@property(nonatomic, strong) CSEvent *event;

@property(nonatomic, copy) CSEventBlock function;

- (instancetype)construct:(CSEvent *)event :(CSEventBlock)function;

- (void)cancel;
@end

NS_ASSUME_NONNULL_END