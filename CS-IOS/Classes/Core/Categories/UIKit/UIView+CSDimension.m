//
// Created by Rene Dohan on 17/07/18.
//

#import "UIView+CSDimension.h"
#import "UIView+CSPosition.h"
#import "UIView+CSAutoResizing.h"

@implementation UIView (CSDimension)

- (CGSize)size {
    return self.frame.size;
}

- (instancetype)size:(CGSize)size {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
    return self;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (instancetype)width:(CGFloat)width height:(CGFloat)height {
    [self size:CGSizeMake(width, height)];
    return self;
}

- (void)setWidth:(CGFloat)value {
    [self width:value];
}

- (instancetype)width:(CGFloat)value {
    CGRect frame = self.frame;
    frame.size.width = value;
    self.frame = frame;
    return self;
}

- (void)setWidthFromRight:(CGFloat)width {
    [self widthFromRight:width];
}

- (instancetype)widthFromRight:(CGFloat)width {
    CGFloat right = self.fromRight;
    self.width = width;
    self.fromRight = right;
    return self;
}


- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    [self height:height];
}

- (instancetype)height:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
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
    return [self width:self.superview.width].centerInParentHorizontal.flexibleWidth;
}

- (instancetype)matchParentWidthWithMargin:(CGFloat)margin {
    return [[self.matchParentWidth left:margin] fromRightToWidth:margin];
}

- (instancetype)matchParentHeightWithMargin:(CGFloat)margin {
    return [[self.matchParentHeight top:margin] fromBottomToHeight:margin];
}

- (instancetype)matchParentHeight {
    return [self height:self.superview.height].centerInParentVertical.flexibleHeight;
}

- (instancetype)addWidth:(int)value {
    self.width += value;
    return self;
}

- (instancetype)addHeight:(int)value {
    self.height += value;
    return self;
}
@end
