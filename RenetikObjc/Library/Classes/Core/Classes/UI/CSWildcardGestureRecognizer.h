//
// Created by Rene Dohan on 04/03/15.
// Copyright (c) 2015 creative_studio. All rights reserved.
//

@import UIKit;

typedef void (^TouchesEventBlock)(NSSet *touches, UIEvent *event);

@interface CSWildcardGestureRecognizer : UIGestureRecognizer {
    TouchesEventBlock touchesBeganCallback;
}
@property(copy) TouchesEventBlock touchesBeganCallback;


- (UIGestureRecognizer *)construct:(void (^)(NSSet *, UIEvent *))pFunction;
@end
