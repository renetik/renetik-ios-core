//
// Created by Rene Dohan on 04/06/14.
// Copyright (c) 2014 creative_studio. All rights reserved.
//

#import "CSEventRegistration.h"
#import "CSEvent.h"

@implementation CSEventRegistration

- (instancetype)construct:(CSEvent *)event :(CSEventBlock)function {
    _event = event;
    _function = function;
    return self;
}

- (void)cancel {
    [_event remove:_function];
}
@end