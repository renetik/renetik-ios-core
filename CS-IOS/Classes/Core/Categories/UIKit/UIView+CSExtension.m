//
//  Created by Rene Dohan on 4/29/12.
//


#import "UIColor+CSExtension.h"

@implementation UIView (CSExtension)

+ (void)hide:(NSArray<UIView *> *)array {
    for (UIView *view in array)[view hide];
}

- (instancetype)clone {
    return [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:self]];
}

- (void)resizeAutoResizingViewsFonts:(float)multiply {
    [self resizeAutoResizingViewsFonts:(self) :multiply];
}

- (void)resizeAutoResizingViewsFonts:(UIView *)view :(float)multiply {
    for (id subview in view.subviews) {
        if ([subview isKindOfClass:UIView.class]) {
            [self resizeAutoResizingViewsFonts:((UIView *) subview) :multiply];
            if ([subview isKindOfClass:UILabel.class]) {
                UILabel *label = (UILabel *) subview;
                if (label.autoresizingMask & UIViewAutoresizingFlexibleWidth && label.autoresizingMask & UIViewAutoresizingFlexibleHeight)
                    label.font = [label.font fontWithSize:label.font.pointSize * multiply];
            }
            if ([subview isKindOfClass:UIButton.class]) {
                UIButton *button = (UIButton *) subview;
                if (button.autoresizingMask & UIViewAutoresizingFlexibleWidth && button.autoresizingMask & UIViewAutoresizingFlexibleHeight)
                    button.titleLabel.font = [button.titleLabel.font fontWithSize:button.titleLabel.font.pointSize * multiply];
            }
        }
    }
}

+ (UIView *)findFirstResponder:(UIView *)view {
    for (UIView *childView in view.subviews) {
        if ([childView respondsToSelector:@selector(isFirstResponder)] && [childView isFirstResponder]) return childView;
        UIView *result = [self findFirstResponder:childView];
        if (result) return result;
    }
    return nil;
}

+ (UIViewAnimationOptions)animationOptionsWithCurve:(UIViewAnimationCurve)curve {
    switch (curve) {
        case UIViewAnimationCurveEaseInOut:return UIViewAnimationOptionCurveEaseInOut;
        case UIViewAnimationCurveEaseIn:return UIViewAnimationOptionCurveEaseIn;
        case UIViewAnimationCurveEaseOut:return UIViewAnimationOptionCurveEaseOut;
        case UIViewAnimationCurveLinear:return UIViewAnimationOptionCurveLinear;
    }
    return UIViewAnimationOptionCurveLinear;
}

- (UIView *)firstResponder {
    return [UIView findFirstResponder:self];
}

+ (instancetype)create:(NSObject *)owner :(NSString *)IBName {
    return [NSBundle.mainBundle loadNibNamed:IBName owner:owner options:nil][0];
}

+ (instancetype)create:(NSString *)IBName {
    return [self create:nil :IBName];
}

+ (instancetype)create {
    NSString *nibName = [self NIBName];
    return [self create:nibName];
}

+ (NSString *)NIBName {
    NSString *className = NSStringFromClass(self.class);
    if ([className contains:@"."]) className = [className split:@"."].second;
    return [className replaceLast:@"View" :@""];
}

- (instancetype)fadeIn {
    if (self.hidden) [self fadeIn:CS_FADE_TIME];
    return self;
}

- (void)fadeBackgroundColorTo:(UIColor *)color {
    if ([self.backgroundColor isEqual:color])return;
    CABasicAnimation *fade = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    fade.fromValue = (id) self.backgroundColor.CGColor;
    fade.toValue = (id) color.CGColor;
    [fade setDuration:CS_FADE_TIME];
    [self.layer addAnimation:fade forKey:@"fadeAnimation"];
    self.backgroundColor = color;
}

- (void)fadeOut {
    if (!self.hidden) [self fadeOut:CS_FADE_TIME];
}

+ (void)animationFromCurrentState:(NSTimeInterval)time :(UIViewAnimationCurve)curve {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:time];
    [UIView setAnimationCurve:curve];
    [UIView setAnimationBeginsFromCurrentState:YES];
}

- (void)fadeToggle {
    if (self.hidden) [self fadeIn];
    else [self fadeOut];
}

+ (instancetype)createEmpty {
    return [self.class.alloc initWithFrame:CGRectZero];
}

+ (instancetype)createEmptyWithColor:(UIColor *)color {
    UIView *view = self.createEmpty;
    view.backgroundColor = color;
    return view;
}

+ (instancetype)createEmptyWithColor:(UIColor *)color frame:(CGRect)frame {
    UIView *view = [self createEmptyWithFrame:frame];
    view.backgroundColor = color;
    return view;
}

+ (instancetype)createEmptyWithFrame:(CGRect)frame {
    return [self.class.alloc initWithFrame:frame];
}

+ (instancetype)createEmptyWithSize:(NSInteger)width :(NSInteger)height {
    return [self.class.alloc initWithFrame:CGRectMake(0, 0, width, height)];
}

- (BOOL)visible {
    return !self.hidden;
}

- (void)setVisible:(BOOL)visible {
    self.hidden = !visible;
}

- (void)setFadeVisible:(BOOL)visible {
    if (visible) [self fadeIn];
    else [self fadeOut];
}

- (UIViewController *)controller {
    return (UIViewController *) [self traverseResponderChainForUIViewController];
}

- (id)traverseResponderChainForUIViewController {
    id nextResponder = [self nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        return nextResponder;
    } else if ([nextResponder isKindOfClass:[UIView class]]) {
        return [nextResponder traverseResponderChainForUIViewController];
    } else {
        return nil;
    }
}

- (void)fadeIn:(NSTimeInterval)time :(void (^)(void))onDone {
    self.hidden = NO;
    self.alpha = self.alpha < 1 ? self.alpha : 0;
    [UIView animateWithDuration:time delay:0
                        options:UIViewAnimationOptionCurveEaseInOut |
                                UIViewAnimationOptionAllowUserInteraction |
                                UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.alpha = 1.0;
                     }
                     completion:^(BOOL finished) {
                         run(onDone);
                     }];
}

- (void)fadeIn:(NSTimeInterval)time {
    [self fadeIn:time :nil];
}

- (id)getView:(int)tag {
    return [self viewWithTag:tag];
}

- (void)fadeOut:(NSTimeInterval)time {
    [self fadeOut:time :nil];
}


- (void)fadeOut:(NSTimeInterval)time :(void (^)(void))method {
    CGFloat alpha = self.alpha;
    [UIView animateWithDuration:time delay:0
                        options:UIViewAnimationOptionCurveEaseInOut |
                                UIViewAnimationOptionAllowUserInteraction |
                                UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [self setAlpha:0.0];
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             [self setHidden:YES];
                             [self setAlpha:alpha];
                         }
                         run(method);
                     }];
}

- (instancetype)setHeight:(float)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
    return self;
}

- (instancetype)setWidth:(float)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
    return self;
}

- (UIView *)setWidthToLeft:(float)width {
    self.left = self.left - (width - self.width);
    self.width = width;
    return self;
}

- (void)setLeft:(float)value {
    CGRect frame = self.frame;
    frame.origin.x = value;
    self.frame = frame;
}

- (void)setRight:(float)right {
    self.left = right - self.width;
}

- (void)setBottom:(float)bottom {
    self.top = bottom - self.height;
}

- (void)setRightToWidth:(float)right {
    self.width = right - self.left;
}

- (void)setBottomToHeight:(float)bottom {
    self.height = bottom - self.top;
}

- (void)setTopToHeight:(float)top {
    self.height = self.bottom - top;
    self.top = top;
}

- (float)height {
    return self.frame.size.height;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
}

- (void)setPosition:(CGPoint)position {
    self.left = position.x;
    self.top = position.y;
}

- (float)top {
    return self.frame.origin.y;
}

- (void)setTop:(float)value {
    CGRect frame = self.frame;
    frame.origin.y = value;
    self.frame = frame;
}

- (float)y {
    return self.frame.origin.y;
}

- (float)absTop {
    return [self convertPoint:CGPointMake(0, self.top) toView:nil].y;
}

- (void)setAbsTop:(float)value {
    self.top = [self convertPoint:CGPointMake(0, value) fromView:nil].y;
}

- (float)left {
    return self.frame.origin.x;
}

- (float)x {
    return self.frame.origin.x;
}

- (float)right {
    return self.left + self.width;
}

- (float)bottom {
    return self.top + self.height;
}

- (float)absBottom {
    return [self convertPoint:CGPointMake(0, self.bottom) toView:nil].y;
}

- (float)width {
    return self.frame.size.width;
}

- (instancetype)clearSubViews {
    for (UIView *view in self.subviews) [view removeFromSuperview];
    return self;
}

- (UIView *)addViewUnderLast:(UIView *)view {
    [self positionViewUnderLast:view];
    [self addSubview:view];
    return view;
}

- (UIView *)addView:(UIView *)view {
    [self addSubview:view];
    return view;
}

- (UIView *)addView:(UIView *)view :(NSInteger)index {
    [self insertSubview:view atIndex:index];
    return view;
}

- (UIView *)setView:(UIView *)view :(NSInteger)index {
    if (self.subviews[(NSUInteger) index])[self.subviews[(NSUInteger) index] removeFromSuperview];
    [self insertSubview:view atIndex:index];
    return view;
}

- (UIView *)positionViewUnderLast:(UIView *)view {
    UIView *lastSubviewOfClass = self.subviews.last;
    if (lastSubviewOfClass) view.top = lastSubviewOfClass.bottom;
    else view.top = 0;
    return view;
}

- (UIView *)findLastSubviewOfClass:(Class)pClass {
    for (NSInteger i = self.subviews.count - 1; i >= 0; i--) {
        UIView *subView = self.subviews[(NSUInteger) i];
        if ([subView isMemberOfClass:pClass])return subView;
    }
    return nil;
}

- (UIView *)addViewNextLast:(UIView *)view {
    [self positionViewNextLast:view];
    [self addSubview:view];
    return view;
}

- (UIView *)addViewNextLastFilingParent:(UIView *)view {
    [self positionViewNextLast:view];
    [self addSubview:view];
    if (view.left == 0) {
        view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
    } else if (view.right == self.width) {
        view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin;
    } else {
        view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth |
                UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    }
    return view;
}

- (UIView *)addViewUnderLastFilingParent:(UIView *)view {
    [self positionViewUnderLast:view];
    [self addSubview:view];
    if (view.top == 0) {
        view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    } else if (view.bottom == self.height) {
        view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    } else {
        view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth |
                UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    }
    return view;
}

- (void)removeSubviewsOfClass:(Class)pClass {
    for (UIView *subview in self.subviews) {
        if ([subview isKindOfClass:pClass])[subview removeFromSuperview];
    }
}

- (UIView *)positionViewNextLast:(UIView *)view {
    UIView *lastSubview = self.subviews.last;
    if (lastSubview) view.left = lastSubview.right;
    else view.left = 0;
    return view;
}

- (instancetype)show {
    self.visible = YES;
    return self;
}

- (instancetype)hide {
    self.visible = NO;
    return self;
}

- (void)resizeByTop:(CGFloat)value {
    self.height -= value - self.top;
    self.top = value;
}

- (instancetype)matchParent {
    [self matchParentWidth];
    [self matchParentHeight];
    [self centerInParent];
    self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    return self;
}

- (UIView *)centerInParent {
    self.center = CGPointMake(self.superview.width / 2, self.superview.height / 2);
    return self;
}

- (instancetype)matchParentHeight {
    self.height = self.superview.height;
    self.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    return self;
}

- (instancetype)flexibleHeight {
    self.height = self.superview.height;
    self.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    return self;
}

- (instancetype)matchParentWidth {
    self.width = self.superview.width;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    return self;
}

- (UIView *)addViewHorizontalSingleLineLayout:(UIView *)view {
    view.height = self.height;
    return [self addViewHorizontalLayout:view];
}

- (UIView *)addViewHorizontalLayout:(UIView *)view {
    UIView *lastSubview = self.subviews.last;
    if (lastSubview) {
        if (lastSubview.right + view.width <= self.width) {
            view.left = lastSubview.right;
            view.top = lastSubview.top;
        } else {
            view.left = 0;
            view.top = lastSubview.bottom;
        }
    } else {
        view.left = 0;
        view.top = 0;
    }
    return [self addView:view];
}

- (UIView *)addViewHorizontalSingleLineReverseLayout:(UIView *)view {
    view.height = self.height;
    return [self addViewHorizontalReverseLayout:view];
}

- (UIView *)addViewHorizontalReverseLayout:(UIView *)view {
    UIView *lastSubview = self.subviews.last;
    if (lastSubview) {
        if (lastSubview.left - view.width >= 0) {
            view.bottom = lastSubview.bottom;
            view.right = lastSubview.left;
        } else {
            view.bottom = lastSubview.top;
            view.right = self.width;
        }
    } else {
        view.bottom = self.height;
        view.right = self.width;
    }
    return [self addView:view];
}

- (UIView *)addViewVerticalLayout:(UIView *)view {
    UIView *lastSubview = self.subviews.last;
    if (lastSubview) {
        if (lastSubview.bottom + view.height <= self.height) {
            view.left = lastSubview.left;
            view.top = lastSubview.bottom;
        } else {
            view.left = lastSubview.right;
            view.top = 0;
        }
    } else {
        view.left = 0;
        view.top = 0;
    }
    return [self addView:view];
}

@end
