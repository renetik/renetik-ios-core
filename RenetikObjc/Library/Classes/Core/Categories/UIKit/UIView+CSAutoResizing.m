//
// Created by Rene Dohan on 17/07/18.
//

#import "UIView+CSAutoResizing.h"
#import "CSLang.h"

@implementation UIView (CSAutoResizing)

- (instancetype)setAutoresizingDefaults {
	self.translatesAutoresizingMaskIntoConstraints = YES;
    self.autoresizingMask = nil;
    self.flexibleLeft.flexibleTop.flexibleRight
    .flexibleBottom.fixedWidth.fixedHeight;
    return self;
}

- (instancetype)flexibleWidthHeight {
    self.flexibleWidth.flexibleHeight;
    return self;
}

- (instancetype)flexibleWidth {
    self.autoresizingMask |= UIViewAutoresizingFlexibleWidth;
    return self;
}

- (instancetype)fixedWidth {
    self.autoresizingMask &= ~UIViewAutoresizingFlexibleWidth;
    return self;
}

- (instancetype)flexibleHeight {
    self.autoresizingMask |= UIViewAutoresizingFlexibleHeight;
    return self;
}

- (instancetype)fixedHeight {
    self.autoresizingMask &= ~UIViewAutoresizingFlexibleHeight;
    return self;
}

- (instancetype)flexibleLeft {
    self.autoresizingMask |= UIViewAutoresizingFlexibleLeftMargin;
    return self;
}

- (instancetype)flexibleTop {
    self.autoresizingMask |= UIViewAutoresizingFlexibleTopMargin;
    return self;
}

- (instancetype)flexibleRight {
    self.autoresizingMask |= UIViewAutoresizingFlexibleRightMargin;
    return self;
}

- (instancetype)flexibleBottom {
    self.autoresizingMask |= UIViewAutoresizingFlexibleBottomMargin;
    return self;
}

- (instancetype)flexibleLeftTop {
    return self.flexibleLeft.flexibleTop;
}

- (instancetype)flexibleLeftBottom {
    return self.flexibleLeft.flexibleBottom;
}

- (instancetype)fixedLeft {
    self.autoresizingMask &= ~UIViewAutoresizingFlexibleLeftMargin;
    return self;
}

- (instancetype)fixedTop {
    self.autoresizingMask &= ~UIViewAutoresizingFlexibleTopMargin;
    return self;
}

- (instancetype)fixedRight {
    self.autoresizingMask &= ~UIViewAutoresizingFlexibleRightMargin;
    return self;
}

- (instancetype)fixedBottom {
    self.autoresizingMask &= ~UIViewAutoresizingFlexibleBottomMargin;
    return self;
}

- (BOOL)isFixedLeft {
    return !bitmaskContains(self.autoresizingMask,
                            UIViewAutoresizingFlexibleLeftMargin);
}

- (BOOL)isFixedTop {
    return !bitmaskContains(self.autoresizingMask,
                            UIViewAutoresizingFlexibleTopMargin);
}

- (BOOL)isFixedRight {
    return !bitmaskContains(self.autoresizingMask,
                            UIViewAutoresizingFlexibleRightMargin);
}

- (BOOL)isFixedBottom {
    return !bitmaskContains(self.autoresizingMask,
                            UIViewAutoresizingFlexibleBottomMargin);
}

@end
