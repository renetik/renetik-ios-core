//
// Created by Rene Dohan on 16/01/14.
// Copyright (c) 2014 creative_studio. All rights reserved.
//

#import "NSDateComponents+CSExtension.h"


@implementation NSDateComponents (CSExtension)

- (NSDateComponents *)withYear:(int)year {
    [self setYear:year];
    return self;
}

@end