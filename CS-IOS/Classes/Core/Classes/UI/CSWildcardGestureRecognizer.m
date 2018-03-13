//
// Created by Rene Dohan on 04/03/15.
// Copyright (c) 2015 creative_studio. All rights reserved.
//

#import "CSWildcardGestureRecognizer.h"


@implementation CSWildcardGestureRecognizer
@synthesize touchesBeganCallback;

- (id)init {
    if (self = [super init]) {
        self.cancelsTouchesInView = NO;
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (touchesBeganCallback)
        touchesBeganCallback(touches, event);
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
}

- (void)reset {
}

- (void)ignoreTouch:(UITouch *)touch forEvent:(UIEvent *)event {
}

- (BOOL)canBePreventedByGestureRecognizer:(UIGestureRecognizer *)preventingGestureRecognizer {
    return NO;
}

- (BOOL)canPreventGestureRecognizer:(UIGestureRecognizer *)preventedGestureRecognizer {
    return NO;
}

- (UIGestureRecognizer *)construct:(void (^)(NSSet *, UIEvent *))pFunction {
    self.touchesBeganCallback = pFunction;
    return self;
}
@end