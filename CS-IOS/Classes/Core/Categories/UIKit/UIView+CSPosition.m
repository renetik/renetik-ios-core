//
// Created by Rene Dohan on 17/07/18.
//

#import "UIView+CSPosition.h"
#import "UIView+CSDimension.h"
#import "CSLang.h"

@implementation UIView (CSPosition)

- (CGPoint)position {
    return self.frame.origin;
}

- (instancetype)position:(CGPoint)position {
    [self left:position.x];
    [self top:position.y];
    return self;
}

- (instancetype)left:(CGFloat)value {
    CGRect frame = self.frame;
    frame.origin.x = value;
    self.frame = frame;
    return self;
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(int)left {
    [self left:left];
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (instancetype)left:(CGFloat)left top:(CGFloat)top {
    return [self position:CGPointMake(left, top)];
}

- (instancetype)left:(CGFloat)left top:(CGFloat)top width:(CGFloat)width height:(CGFloat)height {
    self.frame = CGRectMake(left, top, width, height);
    return self;
}

- (CGFloat)right {
    return self.left + self.width;
}

- (CGFloat)fromRight {
    return self.superview ? self.superview.width - (self.left + self.width) : self.right;
}

- (CGFloat)leftFromRight {
    return self.superview ? self.superview.width - self.left : self.width;
}

- (CGFloat)topFromBottom {
    return self.superview ? self.superview.height - self.top : self.height;
}

- (instancetype)fromRight:(CGFloat)right {
    return [self left:self.superview.width - (right + self.width)];
}

- (void)setFromRight:(CGFloat)value {
    [self fromRight:value];
}

- (instancetype)rightToWidth:(CGFloat)right {
    self.width = right - self.left;
    return self;
}

- (instancetype)leftToWidth:(CGFloat)left {
    self.width = self.right - left;
    [self left:left];
    return self;
}

- (instancetype)fromRightToWidth:(CGFloat)lengthFromRight {
    val right = self.superview.width - lengthFromRight;
    return [self rightToWidth:right];
}

- (instancetype)fromBottomToHeight:(CGFloat)lengthFromBottom {
    val bottom = self.superview.height - lengthFromBottom;
    return [self bottomToHeight:bottom];
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (CGFloat)y {
    return self.top;
}

- (instancetype)top:(CGFloat)value {
    CGRect frame = self.frame;
    frame.origin.y = value;
    self.frame = frame;
    return self;
}

- (void)setTop:(CGFloat)value {
    [self top:value];
}

- (instancetype)verticalCenter:(CGFloat)y {
    [self center:CGPointMake(self.center.x, y)];
    return self;
}

- (instancetype)horizontalCenter:(CGFloat)x {
    [self setCenter:CGPointMake(x, self.center.y)];
    return self;
}

- (instancetype)center:(CGPoint)point {
    self.center = point;
    return self;
}

- (instancetype)center:(CGFloat)x :(CGFloat)y {
    return [self center:CGPointMake(x, y)];
}

- (CGFloat)absTop {
    return [self convertPoint:CGPointMake(0, self.top) toView:nil].y;
}

- (void)setAbsTop:(float)value {
    [self top:[self convertPoint:CGPointMake(0, value) fromView:nil].y];
}

- (instancetype)bottomToHeight:(CGFloat)bottom {
    self.height = bottom - self.top;
    return self;
}

- (instancetype)topToHeight:(CGFloat)top {
    self.height = self.bottom - top;
    [self top:top];
    return self;
}

- (instancetype)fromBottom:(CGFloat)bottom {
    return [self top:self.superview.height - (bottom + self.height)];
}

- (void)setFromBottom:(CGFloat)bottom {
    [self fromBottom:bottom];
}

- (CGFloat)bottom {
    return self.top + self.height;
}

- (void)setBottom:(CGFloat)value {
    self.top = value - self.height;
}

- (instancetype)bottom:(CGFloat)value {
    self.bottom = value;
    return self;
}

- (void)setRight:(CGFloat)value {
    self.left = value - self.width;
}

- (instancetype)right:(CGFloat)value {
    self.right = value;
    return self;
}

- (CGFloat)fromBottom {
    return self.superview ? self.superview.height - (self.top + self.height)
            : self.bottom;
}

- (CGFloat)absBottom {
    return [self convertPoint:CGPointMake(0, self.bottom) toView:nil].y;
}

- (UIView *)centerInParent {
    self.center = CGPointMake(self.superview.width / 2, self.superview.height / 2);
    return self;
}

- (instancetype)centerInParentVertical {
    self.center = CGPointMake(self.center.x, self.superview.height / 2);
    return self;
}

- (instancetype)centerInParentHorizontal {
    self.center = CGPointMake(self.superview.width / 2, self.center.y);
    return self;
}

- (instancetype)addTop:(int)value {
    self.top += value;
    return self;
}

- (instancetype)addLeft:(int)value {
    self.left += value;
    return self;
}

@end