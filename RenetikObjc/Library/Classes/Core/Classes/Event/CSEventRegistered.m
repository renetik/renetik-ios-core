//
// Created by Rene Dohan on 04/06/14.
// Copyright (c) 2014 creative_studio. All rights reserved.
//

#import "CSEventRegistered.h"
#import "CSArgEvent.h"

@implementation CSEventRegistered

- (instancetype)construct:(CSArgEvent *)event :(CSEventBlock)function {
    _event = event;
    _function = function;
    return self;
}

- (void)cancel {
    [_event remove:_function];
}
@end