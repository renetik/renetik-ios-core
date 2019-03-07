//
// Created by Rene Dohan on 17/07/18.
//

#import "CSLang.h"
#import "UIView+CSPosition.h"
#import "UIView+CSDimension.h"
#import "UIView+CSAutoResizing.h"
#import "UIView+CSLayoutGetters.h"
#import "NSException+CSExtension.h"

@implementation UIView (CSPosition)

- (void)setLeft :(int)value {
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
    self.left = self.superview.width - (value + self.width);
}

- (void)setFromBottom :(CGFloat)bottom {
    NSAssert(self.superview, @"Needs to have superview");
    NSAssert(self.height, @"Needs to have height");
    self.top = self.superview.height - (bottom + self.height);
}

- (void)setAbsTop :(float)value {
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
