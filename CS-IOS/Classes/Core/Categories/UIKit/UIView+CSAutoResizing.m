//
// Created by Rene Dohan on 17/07/18.
//

#import "UIView+CSAutoResizing.h"
#import "CSCocoaLumberjack.h"

@implementation UIView (CSAutoResizing)

- (instancetype)flexibleWidthHeight {
    self.flexibleWidth.flexibleHeight;
    return self;
}

- (instancetype)flexibleWidth {
    self.autoresizingMask |= UIViewAutoresizingFlexibleWidth;
    return self;
}

- (instancetype)flexibleHeight {
    self.autoresizingMask |= UIViewAutoresizingFlexibleHeight;
    return self;
}

- (instancetype)flexibleBottom {
    self.autoresizingMask |= UIViewAutoresizingFlexibleBottomMargin;
    return self;
}

- (instancetype)flexibleTop {
    self.autoresizingMask |= UIViewAutoresizingFlexibleTopMargin;
    return self;
}

- (instancetype)flexibleLeft {
    self.autoresizingMask |= UIViewAutoresizingFlexibleLeftMargin;
    return self;
}

- (instancetype)flexibleRight {
    self.autoresizingMask |= UIViewAutoresizingFlexibleRightMargin;
    return self;
}

- (instancetype)fixedRight {
    self.autoresizingMask &= ~UIViewAutoresizingFlexibleRightMargin;
    return self;
}

- (instancetype)fixedLeft {
    self.autoresizingMask &= ~UIViewAutoresizingFlexibleLeftMargin;
    return self;
}

- (instancetype)fixedBottom {
    self.autoresizingMask &= ~UIViewAutoresizingFlexibleBottomMargin;
    return self;
}

- (instancetype)fixedTop {
    self.autoresizingMask &= ~UIViewAutoresizingFlexibleTopMargin;
    return self;
}


@end
