//
// Created by Rene Dohan on 17/07/18.
//

#import "UIView+CSLayoutGetters.h"
#import "CSLang.h"

@implementation UIView (CSLayoutGetters)

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
    return [self convertPoint:CGPointMake(0, self.top) toView:nil].y;
}

- (CGFloat)absBottom {
    return [self convertPoint:CGPointMake(0, self.bottom) toView:nil].y;
}

- (CGSize)size {
    return self.frame.size;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (CGSize)calculateSizeFromSubviews {
    var rect = CGRectZero;
    for (UIView *view in self.subviews) rect = CGRectUnion(rect, view.frame);
    return rect.size;
}
@end
