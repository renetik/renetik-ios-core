//
// Created by Rene Dohan on 16/10/14.
// Copyright (c) 2014 Rene Dohan. All rights reserved.
//

#import "UINib+CSExtension.h"


@implementation UINib (CSExtension)

+ (UINib *)nibWithName:(NSString *)name {
    return [self nibWithNibName:name bundle:nil];
}

@end
