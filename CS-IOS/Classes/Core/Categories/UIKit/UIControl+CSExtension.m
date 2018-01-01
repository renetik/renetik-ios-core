//
//  Created by Rene Dohan on 10/24/12.
//


#import <objc/runtime.h>
#import "UIControl+CSExtension.h"
#import "UIControl+BlocksKit.h"


@implementation UIControl (CSExtension)

- (instancetype)addTouchUp:(id)target :(SEL)action {
    [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return self;
}

- (instancetype)addTouchDown:(id)target :(SEL)action {
    [self addTarget:target action:action forControlEvents:UIControlEventTouchDown];
    return self;
}

- (instancetype)addTouchCancel:(id)target :(SEL)action {
    [self addTarget:target action:action forControlEvents:UIControlEventTouchCancel];
    return self;
}

- (instancetype)addTouchUp:(void (^)(id sender))handler {
    [self bk_addEventHandler:handler forControlEvents:UIControlEventTouchUpInside];
    return self;
}

- (instancetype)addTouchDown:(void (^)(id sender))handler {
    [self bk_addEventHandler:handler forControlEvents:UIControlEventTouchDown];
    return self;
}

- (instancetype)addTouchCancel:(void (^)(id sender))handler {
    [self bk_addEventHandler:handler forControlEvents:UIControlEventTouchCancel];
    return self;
}

@end