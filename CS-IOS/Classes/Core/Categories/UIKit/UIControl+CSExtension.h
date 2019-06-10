//
//  Created by Rene Dohan on 10/24/12.
//


@import UIKit;

static char UIButtonBlockKey;

@interface UIControl (CSExtension)

- (instancetype)addTouchUp:(id)target :(SEL)action;

- (instancetype)addTouchDown:(id)target :(SEL)action;

- (instancetype)addTouchCancel:(id)target :(SEL)action;

- (instancetype)setTouchUp:(void (^)(id sender))handler;

- (instancetype)setTouchDown:(void (^)(id sender))handler;

- (instancetype)setTouchCancel:(void (^)(id sender))handler;

- (void)addTouchEffect;

- (void)onTouchEffect;

- (void)doTouchEffect:(UIColor *)selection;
@end
