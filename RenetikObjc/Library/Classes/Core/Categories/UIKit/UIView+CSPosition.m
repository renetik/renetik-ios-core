//
// Created by Rene Dohan on 17/07/18.
//

#import "CSLang.h"
#import "UIView+CSPosition.h"
#import "UIView+CSDimension.h"
#import "UIView+CSAutoResizing.h"
#import "NSException+CSExtension.h"

@implementation UIView (CSPosition)

- (CGPoint)position {
    return self.frame.origin;
}

- (CGFloat)left {
    return self.x;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (CGFloat)y {
    return self.top;
}

- (CGFloat)right {
    return self.left + self.width;
}

- (CGFloat)bottom {
    return self.top + self.height;
}

- (void)setLeft:(CGFloat)value {
    CGRect frame = self.frame;
    frame.origin.x = value;
    self.frame = frame;
}

- (void)setTop:(CGFloat)value {
    CGRect frame = self.frame;
    frame.origin.y = value;
    self.frame = frame;
}

- (void)setRight:(CGFloat)value {
    self.left = value - self.width;
}

- (void)setBottom:(CGFloat)value {
    self.top = value - self.height;
}

- (instancetype)position:(CGPoint)point {
    CGRect frame = self.frame;
    frame.origin.x = point.x;
    frame.origin.y = point.y;
    self.frame = frame;
    return self;
}

- (instancetype)center:(CGPoint)point {
    self.center = point;
    return self;
}

- (instancetype)center:(CGFloat)x :(CGFloat)y {
    return [self center:CGPointMake(x, y)];
}

- (UIView *)centerInParent {
    NSAssert(self.superview, @"Needs to have superview");
    self.center = CGPointMake(self.superview.width / 2, self.superview.height / 2);
    return self;
}

- (instancetype)centerInParentVertical {
    NSAssert(self.superview, @"Needs to have superview");
    self.center = CGPointMake(self.center.x, self.superview.height / 2);
    return self;
}

- (instancetype)centerInParentHorizontal {
    NSAssert(self.superview, @"Needs to have superview");
    self.center = CGPointMake(self.superview.width / 2, self.center.y);
    return self;
}

@end
