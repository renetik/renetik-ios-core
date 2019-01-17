//
//  Created by Rene Dohan on 4/29/12.
//

@import BlocksKit;

#import "UIView+CSExtension.h"
#import "UIColor+CSExtension.h"
#import "UIView+CSAutoResizing.h"
#import "UIView+CSDimension.h"
#import "UIView+CSPosition.h"
#import "UIView+CSLayoutGetters.h"
#import "CSCocoaLumberjack.h"

static void *csViewContentPropertyKey = &csViewContentPropertyKey;

@implementation UIView (CSExtension)

+ (instancetype)construct {
    return [self.class.new construct];
}

- (instancetype)construct {
    self.autoresizingMask = nil;
    self.flexibleLeft.flexibleTop.flexibleRight.flexibleBottom;
    return self;
}

+ (instancetype)constructByXib:(NSObject *)owner :(NSString *)xibName {
    if (![NSBundle.mainBundle pathForResource:xibName ofType:@"nib"]) return self.createEmpty;
    return [[NSBundle.mainBundle loadNibNamed:xibName owner:owner options:nil][0] construct];
}

+ (instancetype)constructByXib:(NSString *)IBName {
    return [self constructByXib:nil :IBName];
}

+ (instancetype)constructByXib {
    NSString *nibName = [self NIBName];
    return [self constructByXib:nibName];
}

+ (NSString *)NIBName {
    NSString *className = NSStringFromClass(self.class);
    if ([className contains:@"."]) className = [className split:@"."].second;
    return className;
}

- (instancetype)contentMode:(UIViewContentMode)contentMode {
    self.contentMode = contentMode;
    return self;
}

- (instancetype)clipsToBounds:(BOOL)clipsToBounds {
    self.clipsToBounds = clipsToBounds;
    return self;
}

+ (void)animate:(NSTimeInterval)duration :(void (^)(void))animations {
    [UIView animateWithDuration:duration animations:animations];
}

+ (instancetype)wrap:(UIView *)view {
    UIView *container = [self withFrame:view.frame];
    val center = view.center;
    val superview = view.superview;
    val autoSize = view.autoresizingMask;
    [container add:view].matchParent;
    [[superview add:container] center:center].autoresizingMask = autoSize;
    container.backgroundColor = view.backgroundColor;
    view.backgroundColor = UIColor.clearColor;
    return container;
}

+ (instancetype)withContent:(UIView *)view {
    UIView *container = [self withFrame:view.frame];
    [container content:view];
    return container;
}

+ (instancetype)wrap:(UIView *)view withPadding:(int)padding {
    UIView *container = [self withSize:view.width + padding * 2 :view.height + padding * 2];
    val center = view.center;
    val superview = view.superview;
    val autoSize = view.autoresizingMask;
    [[container add:view] matchParentWithMargin:padding];
    [[superview add:container] center:center].autoresizingMask = autoSize;
    container.backgroundColor = view.backgroundColor;
    view.backgroundColor = UIColor.clearColor;
    return container;
}

- (instancetype)asCircular {
    self.layer.cornerRadius = self.width / 2;
    self.clipsToBounds = YES;
    return self;
}

- (instancetype)clone {
    return [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:self]];
}

- (UIView *)firstResponder {
    for (UIView *view in self.subviews) {
        if ([view respondsToSelector:@selector(isFirstResponder)] && [view isFirstResponder])
            return view;
        UIView *result = view.firstResponder;
        if (result) return result;
    }
    return nil;
}

+ (UIViewAnimationOptions)animationOptionsWithCurve:(UIViewAnimationCurve)curve {
    switch (curve) {
        case UIViewAnimationCurveEaseInOut:
            return UIViewAnimationOptionCurveEaseInOut;
        case UIViewAnimationCurveEaseIn:
            return UIViewAnimationOptionCurveEaseIn;
        case UIViewAnimationCurveEaseOut:
            return UIViewAnimationOptionCurveEaseOut;
        case UIViewAnimationCurveLinear:
            return UIViewAnimationOptionCurveLinear;
    }
    return UIViewAnimationOptionCurveLinear;
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

- (void)setBackColor:(UIColor *)color {
    self.backgroundColor = color;
}

- (instancetype)backColor:(UIColor *)color {
    self.backgroundColor = color;
    return self;
}

- (UIColor *)backColor {
    return self.backgroundColor;
}

- (instancetype)tintColor:(UIColor *)color {
    self.tintColor = color;
    return self;
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
    return [[self.class.alloc initWithFrame:CGRectZero] construct];
}

+ (instancetype)withColor:(UIColor *)color {
    UIView *view = self.createEmpty;
    view.backgroundColor = color;
    return view;
}

+ (instancetype)withColor:(UIColor *)color frame:(CGRect)frame {
    UIView *view = [self withFrame:frame];
    view.backgroundColor = color;
    return view;
}

+ (instancetype)withFrame:(CGRect)frame {
    return [[self.class.alloc initWithFrame:frame] construct];
}

+ (instancetype)withSize:(CGFloat)width :(CGFloat)height {
    return [[self.class.alloc initWithFrame:CGRectMake(0, 0, width, height)] construct];
}

+ (instancetype)withRect:(CGFloat)left :(CGFloat)top :(CGFloat)width :(CGFloat)height {
    return [[self.class.alloc initWithFrame:CGRectMake(left, top, width, height)] construct];
}

+ (instancetype)withHeight:(CGFloat)height {
    return [[self.class.alloc initWithFrame:CGRectMake(0, 0, 1, height)] construct];
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

- (instancetype)clearSubViews {
    for (UIView *view in self.subviews) [view removeFromSuperview];
    return self;
}

- (UIView *)add:(UIView *)view {
    [self addSubview:view];
    return view;
}

- (instancetype)addViews:(NSArray<UIView *> *)views {
    for (UIView *view in views) [self addSubview:view];
    return self;
}

- (UIView *)insertView:(UIView *)view :(NSInteger)index {
    [self insertSubview:view atIndex:index];
    return view;
}

- (UIView *)setView:(UIView *)view :(NSInteger)index {
    if ([self.subviews at:index])[[self.subviews at:index] removeFromSuperview];
    [self insertSubview:view atIndex:index];
    return view;
}

- (UIView *)findLastSubviewOfClass:(Class)pClass {
    for (NSInteger i = self.subviews.count - 1; i >= 0; i--) {
        UIView *subView = self.subviews[(NSUInteger) i];
        if ([subView isMemberOfClass:pClass])return subView;
    }
    return nil;
}

- (UIView *)addNextLast:(UIView *)view {
    [self positionViewNextLast:view];
    [self addSubview:view];
    return view;
}

- (UIView *)positionViewNextLast:(UIView *)view {
    UIView *lastSubview = self.subviews.last;
    [view left:lastSubview ? lastSubview.right : 0];
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

- (UIView *)addViewHorizontalSingleLineLayout:(UIView *)view {
    view.height = self.height;
    return [self addViewHorizontalLayout:view];
}

- (UIView *)addViewHorizontalLayout:(UIView *)view {
    UIView *lastSubview = self.subviews.last;
    if (lastSubview) {
        if (lastSubview.right + view.width <= self.width) {
            [view left:lastSubview.right];
            [view top:lastSubview.top];
        } else {
            [view left:0];
            [view top:lastSubview.bottom];
        }
    } else {
        [view left:0];
        [view top:0];
    }
    return [self add:view];
}

- (UIView *)addViewHorizontalSingleLineReverseLayout:(UIView *)view {
    view.height = self.height;
    return [self addViewHorizontalReverseLayout:view];
}

- (UIView *)addViewHorizontalReverseLayout:(UIView *)view {
    UIView *lastSubview = self.subviews.last;
    if (lastSubview) {
        if (lastSubview.left - view.width >= 0) {
            [view fromBottom:lastSubview.bottom];
            [view fromRight:lastSubview.left];
        } else {
            [view fromBottom:lastSubview.top];
            [view fromRight:self.width];
        }
    } else {
        [view fromBottom:self.height];
        [view fromRight:self.width];
    }
    return [self add:view];
}

- (UIView *)addViewVerticalLayout:(UIView *)view {
    UIView *lastSubview = self.subviews.last;
    if (lastSubview) {
        if (lastSubview.bottom + view.height <= self.height) {
            [view left:lastSubview.left];
            [view top:lastSubview.bottom];
        } else {
            [view left:lastSubview.right];
            [view top:0];
        }
    } else {
        [view left:0];
        [view top:0];
    }
    return [self add:view];
}

- (UIView *)addUnderLast:(UIView *)view offset:(int)offset {
    if ([self positionUnderLast:view].top != 0) view.top += offset;
    return [self add:view];
}

- (UIView *)addUnderLast:(UIView *)view {
    return [self addUnderLast:view offset:0];
}

- (UIView *)positionUnderLast:(UIView *)view {
    UIView *lastSubviewOfClass = self.subviews.last;
    [view top:lastSubviewOfClass ? lastSubviewOfClass.bottom : 0];
    return view;
}

- (instancetype)onTap:(void (^)(id))block {
    self.userInteractionEnabled = YES;
    [self bk_whenTapped:^{block(self);}];
    return self;
}

- (void)setOnTap:(void (^)(id))block {
    [self onTap:block];
}

- (BOOL)isVisibleToUser {
    infof(@"%@ %@ %@", self.window, @(self.hidden), @(self.alpha));
    return self.window && !self.hidden && self.alpha > 0;
}

- (UIView *)content:(UIView *)view {
    self.content = view;
    return view;
}

- (void)setContent:(UIView *)view {
    [self setWeakObject:csViewContentPropertyKey :view];
    [self add:view];
}

- (UIView *)content {
    return [self getObject:csViewContentPropertyKey];
}

- (instancetype)aspectFit {
    self.contentMode = UIViewContentModeScaleAspectFit;
    return self;
}

- (instancetype)aspectFill {
    self.contentMode = UIViewContentModeScaleAspectFill;
    return self;
}

- (UIView *)addBottomSeparator:(CGFloat)height {
    return [[[[self add:UIView.construct] height:height] fromBottom:0]
            .matchParentWidth.flexibleTop.fixedBottom backColor:UIColor.darkGrayColor];
}

@end
