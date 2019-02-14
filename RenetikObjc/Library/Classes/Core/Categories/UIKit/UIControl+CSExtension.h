//
//  Created by Rene Dohan on 10/24/12.
//

@import UIKit;

static char UIButtonBlockKey;

@interface UIControl (CSExtension)

- (instancetype)addTouchUp:(id)target :(SEL)action;

- (instancetype)addTouchDown:(id)target :(SEL)action;

- (instancetype)addTouchCancel:(id)target :(SEL)action;

- (instancetype)onTouchUp:(void (^)(id sender))handler;

- (instancetype)addTouchDown:(void (^)(id sender))handler;

- (instancetype)addTouchCancel:(void (^)(id sender))handler;

@end
