//
// Created by Rene on 11/25/18.
//

#import "UIView+CSLayout.h"
#import "UIView+CSPosition.h"
#import "UIView+CSDimension.h"
#import "UIView+CSAutoResizing.h"
#import "CSLang.h"
#import "UIView+CSContainer.h"
#import "CSMath.h"

@implementation UIView (CSLayout)

- (instancetype)widthFromLeft:(CGFloat)left {
    self.width = [CSMath unsign:self.right - left];
    [self fromLeft:left];
    return self;
}

- (instancetype)widthByRight:(CGFloat)right {
    self.width = [CSMath unsign:right - self.left];
    [self fixedRight];
    return self;
}

- (instancetype)heightFromTop:(CGFloat)top {
    self.height = [CSMath unsign:self.bottom - top];
    [self fromTop:top];
    return self;
}

- (instancetype)heightByBottom:(CGFloat)bottom {
    self.height = [CSMath unsign:bottom - self.top];
    [self fixedBottom];
    return self;
}

- (instancetype)fromLeft:(CGFloat)value {
    self.left = value;
    [self fixedLeft];
    return self;
}

- (instancetype)fromTop:(CGFloat)value {
    self.top = value;
    [self fixedTop];
    return self;
}

- (instancetype)fromRight:(CGFloat)value {
    self.fromRight = value;
    [self fixedRight];
    return self;
}

- (instancetype)fromBottom:(CGFloat)bottom {
    self.fromBottom = bottom;
    [self fixedBottom];
    return self;
}

- (instancetype)fromTopRight:(CGFloat)value {
    [self fromTop:value];
    [self fromRight:value];
    return self;
}

- (instancetype)fromTopLeft:(CGFloat)value {
    [self fromTop:value];
    [self fromLeft:value];
    return self;
}

- (instancetype)fromBottomRight:(CGFloat)value {
    [self fromBottom:value];
    [self fromRight:value];
    return self;
}

- (instancetype)fromBottomLeft:(CGFloat)value {
    [self fromBottom:value];
    [self fromLeft:value];
    return self;
}

- (instancetype)fromLeft:(CGFloat)left top:(CGFloat)top {
    [self fromLeft:left];
    [self fromTop:top];
    return self;
}

- (instancetype)fromLeft:(CGFloat)left bottom:(CGFloat)bottom {
    [self fromLeft:left];
    [self fromBottom:bottom];
    return self;
}

- (instancetype)fromLeft:(CGFloat)left top:(CGFloat)top width:(CGFloat)width height:(CGFloat)height {
    [self fromLeft:left top:top];
    [self width:width height:height];
    return self;
}

- (instancetype)widthFromRight:(CGFloat)distanceFromRight {
    NSAssert(self.superview, @"Needs to have superview");
    let right = self.superview.width - distanceFromRight;
    return [self widthByRight:[CSMath unsign:right]];
}

- (instancetype)heightFromBottom:(CGFloat)distanceFromBottom {
    NSAssert(self.superview, @"Needs to have superview");
    let bottom = self.superview.height - distanceFromBottom;
    return [self heightByBottom:[CSMath unsign:bottom]];
}

- (instancetype)fixedRightSetWidth:(CGFloat)width {
    CGFloat right = self.fromRight;
    self.width = width;
    self.fromRight = right;
    [self fixedRight];
    return self;
}

- (instancetype)fixedBottomSetHeight:(CGFloat)height {
    CGFloat bottom = self.fromBottom;
    self.height = height;
    self.fromBottom = bottom;
    [self fixedBottom];
    return self;
}

- (instancetype)heightDisabledAutosizing:(CGFloat)height {
    self.autoresizesSubviews = false;
    [self height:height];
    self.autoresizesSubviews = true;
    return self;
}

- (instancetype)widthDisabledAutosizing:(CGFloat)width {
    self.autoresizesSubviews = false;
    [self width:width];
    self.autoresizesSubviews = true;
    return self;
}

- (instancetype)matchParent {
    [self matchParentWidth];
    [self matchParentHeight];
    return self;
}

- (instancetype)matchParentWithMargin:(CGFloat)margin {
    return [[self matchParentWidthWithMargin:margin] matchParentHeightWithMargin:margin];
}

- (instancetype)matchParentWidth {
    NSAssert(self.superview, @"Needs to have superview");
    return [self width:self.superview.width].centerInParentHorizontal.flexibleWidth.fixedLeft.fixedRight;
}

- (instancetype)matchParentWidthWithMargin:(CGFloat)margin {
    return [[self.matchParentWidth fromLeft:margin] widthFromRight:margin];
}

- (instancetype)matchParentHeightWithMargin:(CGFloat)margin {
    return [[self.matchParentHeight fromTop:margin] heightFromBottom:margin];
}

- (instancetype)matchParentHeight {
    NSAssert(self.superview, @"Needs to have superview");
    return [self height:self.superview.height].centerInParentVertical.flexibleHeight.fixedTop.fixedBottom;
}

- (instancetype)contentPaddingVertical:(CGFloat)padding {
    [self.content fromTop:padding];
    [self.content heightFromBottom:padding];
    [self.content flexibleWidth];
    return self;
}

- (instancetype)contentPaddingHorizontal:(CGFloat)padding {
    [self.content fromLeft:padding];
    [self.content widthFromRight:padding];
    [self.content flexibleHeight];
    return self;
}

- (instancetype)contentPadding:(CGFloat)padding {
    [self contentPaddingHorizontal:padding];
    [self contentPaddingVertical:padding];
    return self;
}

@end
