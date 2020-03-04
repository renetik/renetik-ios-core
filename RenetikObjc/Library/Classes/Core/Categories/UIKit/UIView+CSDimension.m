//
// Created by Rene Dohan on 17/07/18.
//

#import "UIView+CSDimension.h"
#import "UIView+CSPosition.h"
#import "UIView+CSAutoResizing.h"
#import "CSLang.h"
#import "NSException+CSExtension.h"

@implementation UIView (CSDimension)

- (CGFloat)width {
    return self.frame.size.width;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setWidth:(CGFloat)value {
    var frame = self.frame;
    frame.size.width = value;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)value {
    var frame = self.frame;
    frame.size.height = value;
    self.frame = frame;
}

- (instancetype)width:(CGFloat)value {
    self.width = value;
    return self;
}

- (instancetype)widthAsHeight {
    self.width = self.height;
    return self;
}

- (instancetype)height:(CGFloat)value {
    self.height = value;
    return self;
}

- (instancetype)hideByHeightIf:(BOOL)hide {
    if (hide) self.height = 0;
    return self;
}

- (instancetype)heightAsWidth {
    self.height = self.width;
    return self;
}

- (instancetype)addWidth:(CGFloat)value {
    self.width += value;
    return self;
}

- (instancetype)addHeight:(CGFloat)value {
    self.height += value;
    return self;
}

- (instancetype)removeWidth:(CGFloat)value {
    self.width -= value;
    return self;
}

- (instancetype)removeHeight:(CGFloat)value {
    self.height -= value;
    return self;
}

- (instancetype)resizeToFit {
    [self sizeToFit];
    return self;
}

- (CGFloat)calculateHeightToFitWidth {
    if (self.width <= 0) {
        @throw [NSException exceptionWithName:@"Width has to be set to calculate height"];
    }
    let newSize = [self sizeThatFits:CGSizeMake(self.width, MAXFLOAT)];
    return newSize.height;
}

- (instancetype)heightToFit {
    return [self height:[self calculateHeightToFitWidth]];
}

- (instancetype)widthToFit {
    if (self.height <= 0) {
        @throw [NSException exceptionWithName:@"Height has to be set to calculate width"];
    }
    let newSize = [self sizeThatFits:CGSizeMake(MAXFLOAT, self.height)];
    return [self width:newSize.width];
}

- (instancetype)resizeByPadding:(CGFloat)padding {
    if (self.isFixedLeft) [self addRight:padding]; else [self addLeft:padding];
    if (self.isFixedTop) [self addBottom:padding]; else [self addTop:padding];
    if (self.isFixedRight) [self addLeft:padding]; else [self addRight:padding];
    if (self.isFixedBottom) [self addTop:padding]; else [self addBottom:padding];
    return self;
}

- (instancetype)addLeft:(CGFloat)value {
    self.left -= value;
    self.width += value;
    return self;
}

- (instancetype)addTop:(CGFloat)value {
    self.top -= value;
    self.height += value;
    return self;
}

- (instancetype)addRight:(CGFloat)value {
    self.width += value;
    return self;
}

- (instancetype)addBottom:(CGFloat)value {
    self.height += value;
    return self;
}

@end
