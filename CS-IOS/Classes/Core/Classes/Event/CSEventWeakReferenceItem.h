//
// Created by Rene Dohan on 23/04/14.
// Copyright (c) 2014 creative_studio. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CSEventWeakReferenceItem : NSObject

@property(nonatomic, readonly, weak) void (^block)();

- (id)initWithObject:(void (^)())object;
@end