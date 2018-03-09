//
// Created by Rene Dohan on 01/04/14.
// Copyright (c) 2014 creative_studio. All rights reserved.
//

#import "CSLang.h"
#import "CSToolbar.h"

@implementation CSToolbar

- (void)drawRect:(CGRect)rect {
    if (CGColorGetAlpha(self.backgroundColor.CGColor) > 0.f) {
        [super drawRect:rect];
    }
}

- (void)setTransparent {
    //iOS3+
    self.backgroundColor = [UIColor clearColor];

    //iOS5+
    if ([self respondsToSelector:@selector(setBackgroundImage:forToolbarPosition:barMetrics:)]) {
        [self setBackgroundImage:UIImage.new forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    }
    //iOS6+
    if ([self respondsToSelector:@selector(setShadowImage:forToolbarPosition:)]) {
        [self setShadowImage:UIImage.new forToolbarPosition:UIToolbarPositionAny];
    }
}

@end
