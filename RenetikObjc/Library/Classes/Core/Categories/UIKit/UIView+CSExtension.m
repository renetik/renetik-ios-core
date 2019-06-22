//
//  Created by Rene Dohan on 4/29/12.
//

@import BlocksKit;

#import "UIView+CSExtension.h"
#import "CSLang.h"
#import "NSString+CSExtension.h"
#import "NSArray+CSExtension.h"
#import "UIColor+CSExtension.h"
#import "UIView+CSAutoResizing.h"
#import "UIView+CSDimension.h"
#import "UIView+CSPosition.h"
#import "UIView+CSLayout.h"
#import "CSCocoaLumberjack.h"
#import "NSObject+CSExtension.h"

@implementation UIView (CSExtension)

+ (instancetype)construct {
    return [self.class.new construct];
}

- (instancetype)construct {
    self.clipsToBounds = YES;
	self.setAutoresizingDefaults;
//	self.autoresizingMask = nil;
//	self.flexibleLeft.flexibleTop.flexibleRight
//	.flexibleBottom.fixedWidth.fixedHeight;
    return self;
}

+ (instancetype)constructByXib :(NSObject*)owner :(NSString*)xibName {
    if(![NSBundle.mainBundle pathForResource:xibName ofType:@"nib"]) return self.createEmpty;
    return [[NSBundle.mainBundle loadNibNamed:xibName owner:owner options:nil][0] construct];
}

+ (instancetype)constructByXib :(NSString*)IBName {
    return [self constructByXib:nil :IBName];
}

+ (instancetype)constructByXib {
    NSString*nibName = [self NIBName];
    return [self constructByXib:nibName];
}

+ (NSString*)NIBName {
    NSString*className = NSStringFromClass(self.class);
    if([className contains:@"."]) className = [className split:@"."].second;
    return className;
}

- (instancetype)contentMode :(UIViewContentMode)contentMode {
    self.contentMode = contentMode;
    return self;
}

- (instancetype)clipsToBounds :(BOOL)clipsToBounds {
    self.clipsToBounds = clipsToBounds;
    return self;
}

+ (void)animate :(NSTimeInterval)duration :(void (^)(void))animations {
    [UIView animateWithDuration:duration animations:animations];
}

- (instancetype)asCircular {
//    let longerSide = self.width > self.width ? self.width : self.height;
    [self aspectFill];
    self.layer.cornerRadius = self.width / 2;
    self.layer.masksToBounds = true;
    self.clipsToBounds = YES;
    return self;
}

- (instancetype)roundedCorners :(NSInteger)width {
    self.layer.cornerRadius = width;
    self.layer.masksToBounds = true;
    self.clipsToBounds = YES;
    return self;
}

- (instancetype)clone {
    return [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:self]];
}

- (UIView*)firstResponder {
    for(UIView*view in self.subviews) {
        if([view respondsToSelector:@selector(isFirstResponder)]
           && [view isFirstResponder]) return view;
        UIView*result = view.firstResponder;
        if(result) return result;
    }
    return nil;
}

+ (UIViewAnimationOptions)animationOptionsWithCurve :(UIViewAnimationCurve)curve {
    switch(curve) {
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
    if(self.hidden) [self fadeIn:CS_FADE_TIME];
    return self;
}

- (void)fadeBackgroundColorTo :(UIColor*)color {
    if([self.backgroundColor isEqual:color]) return;
    let fade = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    fade.fromValue = (id)self.backgroundColor.CGColor;
    fade.toValue = (id)color.CGColor;
    [fade setDuration:CS_FADE_TIME];
    [self.layer addAnimation:fade forKey:@"fadeAnimation"];
    self.backgroundColor = color;
}

- (instancetype)background :(UIColor*)color {
    self.backgroundColor = color;
    return self;
}

- (instancetype)tintColor :(UIColor*)color {
    self.tintColor = color;
    return self;
}

- (void)fadeOut {
    if(!self.hidden) [self fadeOut:CS_FADE_TIME];
}

+ (void)animationFromCurrentState :(NSTimeInterval)time :(UIViewAnimationCurve)curve {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:time];
    [UIView setAnimationCurve:curve];
    [UIView setAnimationBeginsFromCurrentState:YES];
}

- (void)fadeToggle {
    if(self.hidden) [self fadeIn];
    else [self fadeOut];
}

+ (instancetype)createEmpty {
    return [[self.class.alloc initWithFrame:CGRectZero] construct];
}

+ (instancetype)withColor :(UIColor*)color {
    UIView*instance = self.createEmpty;
    instance.backgroundColor = color;
    return instance;
}

+ (instancetype)withColor :(UIColor*)color frame :(CGRect)frame {
    UIView*instance = [self withFrame:frame];
    instance.backgroundColor = color;
    return instance;
}

+ (instancetype)withFrame :(CGRect)frame {
    return [[self.class.alloc initWithFrame:frame] construct];
}

+ (instancetype)withSize :(CGFloat)width :(CGFloat)height {
    return [[self.class.alloc initWithFrame:CGRectMake(0, 0, width, height)] construct];
}

+ (instancetype)withRect :(CGFloat)left :(CGFloat)top :(CGFloat)width :(CGFloat)height {
    return [[self.class.alloc initWithFrame:CGRectMake(left, top, width, height)] construct];
}

+ (instancetype)withHeight :(CGFloat)height {
    return [[self.class.alloc initWithFrame:CGRectMake(0, 0, 1, height)] construct];
}

- (BOOL)visible {
    return !self.hidden;
}

- (void)setVisible :(BOOL)visible {
    self.hidden = !visible;
}

- (void)setFadeVisible :(BOOL)visible {
    if(visible) [self fadeIn];
    else [self fadeOut];
}

- (void)fadeIn :(NSTimeInterval)time :(void (^)(void))onDone {
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

- (void)fadeIn :(NSTimeInterval)time {
    [self fadeIn:time :nil];
}

- (id)getView :(NSInteger)tag {
    return [self viewWithTag:tag];
}

- (void)fadeOut :(NSTimeInterval)time {
    [self fadeOut:time :nil];
}

- (void)fadeOut :(NSTimeInterval)time :(void (^)(void))method {
    CGFloat alpha = self.alpha;
    [UIView animateWithDuration:time delay:0
                        options:UIViewAnimationOptionCurveEaseInOut |
     UIViewAnimationOptionAllowUserInteraction |
     UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
        [self setAlpha:0.0];
    }
                     completion:^(BOOL finished) {
        if(finished) {
            [self setHidden:YES];
            [self setAlpha:alpha];
        }
        run(method);
    }];
}

- (instancetype)show {
    self.visible = YES;
    return self;
}

- (instancetype)hide {
    self.visible = NO;
    return self;
}

- (instancetype)onClick :(void (^)(UIView*))block {
    self.userInteractionEnabled = YES;
    [self bk_whenTapped:^{ block(self); }];
    return self;
}

- (void)setOnClick :(void (^)(UIView*))block {
    [self onClick:block];
}

- (BOOL)isVisibleToUser {
    infof(@"%@ %@ %@", self.window, @(self.hidden), @(self.alpha));
    return self.window && !self.hidden && self.alpha > 0;
}

- (instancetype)aspectFit {
    self.contentMode = UIViewContentModeScaleAspectFit;
    return self;
}

- (instancetype)clipToBounds {
    self.clipsToBounds = true;
    return self;
}

- (instancetype)aspectFill {
    self.contentMode = UIViewContentModeScaleAspectFill;
    return self;
}

- (UIView*)addBottomSeparator :(CGFloat)height {
    return [[self add:UIView.construct] asBottomSeparator:height];
}

- (instancetype)asBottomSeparator :(CGFloat)height {
    return [[[self height:height] fromBottom:0]
            .matchParentWidth.flexibleTop.fixedBottom background:UIColor.darkGrayColor];
}

@end
