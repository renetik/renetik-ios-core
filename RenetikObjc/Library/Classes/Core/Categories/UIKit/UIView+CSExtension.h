//
//  Created by Rene Dohan on 4/29/12.
//
@import UIKit;

@class MBProgressHUD;

static float const CS_FADE_TIME = 0.3;

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CSExtension)

+ (instancetype)construct;

- (instancetype)construct;

+ (instancetype)constructByXib:(NSString *)IBName;

+ (instancetype)constructByXib;

- (instancetype)contentMode:(UIViewContentMode)contentMode;

- (instancetype)clipsToBounds:(BOOL)clipsToBounds;

+ (void)animate:(NSTimeInterval)duration :(void (^)(void))animations;

+ (instancetype)wrap:(UIView *)view;

+ (instancetype)withContent:(UIView *)view;

+ (instancetype)wrap:(UIView *)view withPadding:(int)padding;

- (instancetype)asCircular;

- (instancetype)clone;

+ (UIViewAnimationOptions)animationOptionsWithCurve:(UIViewAnimationCurve)curve;

- (UIView *)firstResponder;

+ (NSString *)NIBName;

+ (void)animationFromCurrentState:(NSTimeInterval)time :(UIViewAnimationCurve)curve;

+ (instancetype)createEmpty;

+ (instancetype)withColor:(UIColor *)color;

+ (instancetype)withColor:(UIColor *)color frame:(CGRect)frame;

+ (instancetype)withFrame:(CGRect)frame;

+ (instancetype)withSize:(CGFloat)width :(CGFloat)height;

+ (instancetype)withRect:(CGFloat)left :(CGFloat)top :(CGFloat)width :(CGFloat)height;

+ (instancetype)withHeight:(CGFloat)height;

- (instancetype)fadeIn;

- (void)fadeIn:(NSTimeInterval)time :(void (^)(void))onDone;

- (void)fadeIn:(NSTimeInterval)time;

- (void)fadeBackgroundColorTo:(UIColor *)color;

- (void)fadeOut:(NSTimeInterval)time;

- (void)fadeOut:(NSTimeInterval)time :(void (^)(void))method;

- (instancetype)background:(UIColor *)color;

- (instancetype)tintColor:(UIColor *)color;

- (void)fadeOut;

- (void)fadeToggle;

- (void)setVisible:(BOOL)visible;

- (void)setFadeVisible:(BOOL)visible;

- (BOOL)visible;

- (id)getView:(int)tag;

- (instancetype)clearSubViews;

- (instancetype)show;

- (instancetype)hide;

- (UIView *)add:(UIView *)view;

- (instancetype)addViews:(NSArray<UIView *> *)views;

- (UIView *)insertView:(UIView *)view :(NSInteger)index;

- (UIView *)setView:(UIView *)view :(NSInteger)index;

- (UIView *)positionUnderLast:(UIView *)view;

- (UIView *)addNextLast:(UIView *)view;

- (UIView *)positionViewNextLast:(UIView *)view;

- (UIView *)addViewHorizontalSingleLineLayout:(UIView *)view;

- (UIView *)addViewHorizontalLayout:(UIView *)view;

- (UIView *)addViewHorizontalSingleLineReverseLayout:(UIView *)view;

- (UIView *)addViewHorizontalReverseLayout:(UIView *)view;

- (UIView *)addViewVerticalLayout:(UIView *)view;

- (UIView *)addUnderLast:(UIView *)view offset:(NSInteger)offset;

- (UIView *)addUnderLast:(UIView *)view;

- (instancetype)onTap:(void (^)(UIView *))block;

- (void)setOnTap:(void (^)(UIView *))block;

- (BOOL)isVisibleToUser;

- (UIView *)content:(UIView *)view;

@property(nonatomic) UIView *content;

- (instancetype)aspectFit;

- (instancetype)aspectFill;

- (UIView *)addBottomSeparator:(CGFloat)height;

- (instancetype)asBottomSeparator:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
