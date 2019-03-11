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

- (CGFloat)fromRight {
    return self.superview ? self.superview.width - (self.left + self.width) : self.right;
}

- (CGFloat)fromBottom {
    return self.superview ? self.superview.height - (self.top + self.height) : self.bottom;
}

- (CGFloat)leftFromRight {
    return self.superview ? self.superview.width - self.left : self.width;
}

- (CGFloat)topFromBottom {
    return self.superview ? self.superview.height - self.top : self.height;
}

- (CGFloat)absTop {
    return [self convertPoint :CGPointMake(0, self.top) toView :nil].y;
}

- (CGFloat)absBottom {
    return [self convertPoint :CGPointMake(0, self.bottom) toView :nil].y;
}

- (CGFloat)verticalCenter {
    return self.center.y;
}

- (CGFloat)horizontalCenter {
    return self.center.x;
}

- (void)setLeft :(CGFloat)value {
    CGRect frame = self.frame;
    frame.origin.x = value;
    self.frame = frame;
}

- (void)setTop :(CGFloat)value {
    CGRect frame = self.frame;
    frame.origin.y = value;
    self.frame = frame;
}

- (void)setRight :(CGFloat)value {
    self.left = value - self.width;
}

- (void)setBottom :(CGFloat)value {
    self.top = value - self.height;
}

- (void)setFromRight :(CGFloat)value {
    NSAssert(self.superview, @"Needs to have superview");
    NSAssert(self.width, @"Needs to have width");
    let superViewWidth = self.superview.width;
    let width = self.width;
    let left = superViewWidth - (value + width);
    self.left = left;
}

- (void)setFromBottom :(CGFloat)bottom {
    NSAssert(self.superview, @"Needs to have superview");
    NSAssert(self.height, @"Needs to have height");
    self.top = self.superview.height - (bottom + self.height);
}

- (void)setAbsTop :(CGFloat)value {
    self.top = [self convertPoint :CGPointMake(0, value) fromView :nil].y;
}

- (instancetype)verticalCenter :(CGFloat)y {
    [self center :CGPointMake(self.center.x, y)];
    return self;
}

- (instancetype)horizontalCenter :(CGFloat)x {
    [self setCenter :CGPointMake(x, self.center.y)];
    return self;
}

- (instancetype)center :(CGPoint)point {
    self.center = point;
    return self;
}

- (instancetype)center :(CGFloat)x :(CGFloat)y {
    return [self center :CGPointMake(x, y)];
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
