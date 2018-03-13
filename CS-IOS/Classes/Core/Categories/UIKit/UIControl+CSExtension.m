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

- (instancetype)setTouchUp:(void (^)(id sender))handler {
    [self bk_addEventHandler:handler forControlEvents:UIControlEventTouchUpInside];
    return self;
}

- (instancetype)setTouchDown:(void (^)(id sender))handler {
    [self bk_addEventHandler:handler forControlEvents:UIControlEventTouchDown];
    return self;
}

- (instancetype)setTouchCancel:(void (^)(id sender))handler {
    [self bk_addEventHandler:handler forControlEvents:UIControlEventTouchCancel];
    return self;
}

- (void)addTouchEffect {
    [self addTouchUp: self:@selector(onTouchEffect)];
}

- (void)onTouchEffect {
    [self doTouchEffect:[UIColor colorWithRGBA:150 :150 :150 :0.5]];
}

- (void)doTouchEffect:(UIColor *)selection {
    UIColor *previousColor = self.backgroundColor;
    self.backgroundColor = selection;
    doLater(^{
        self.backgroundColor = previousColor;
    }, 0.3);
}
@end