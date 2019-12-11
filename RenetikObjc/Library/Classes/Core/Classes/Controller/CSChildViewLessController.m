//
// Created by Rene Dohan on 15/03/15.
// Copyright (c) 2015 creative_studio. All rights reserved.
//

#import "CSChildViewLessController.h"
#import "UIViewController+CSExtension.h"
#import "CSMainController.h"
#import "CSLang.h"

@implementation CSChildViewLessController

- (instancetype)construct :(UIViewController*)parent {
    invoke(^{ [parent showChildController:self]; });
    self.showing = YES;
    return self;
}
@end
