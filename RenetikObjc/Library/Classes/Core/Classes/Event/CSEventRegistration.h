//
// Created by Rene Dohan on 04/06/14.
// Copyright (c) 2014 creative_studio. All rights reserved.
//

@import Foundation;

#import "CSArgEvent.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSEventRegistration : NSObject

@property(nonatomic, strong) CSArgEvent *event;

@property(nonatomic, copy) CSEventBlock function;

- (instancetype)construct:(CSArgEvent *)event :(CSEventBlock)function;

- (void)cancel;
@end

NS_ASSUME_NONNULL_END