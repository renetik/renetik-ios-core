//
// Created by Rene Dohan on 23/04/14.
// Copyright (c) 2014 creative_studio. All rights reserved.
//

@import Foundation;

@interface CSEventWeakReferenceItem : NSObject

@property(nonatomic, readonly, weak) void (^block)(void);

- (id)initWithObject:(void (^)(void))object;
@end