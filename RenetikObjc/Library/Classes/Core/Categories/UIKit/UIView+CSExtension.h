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

- (instancetype)asCircular;

- (instancetype)roundedCorners:(NSInteger)width;

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

@property BOOL visible;

- (instancetype)visible:(BOOL)visible;

- (void)setFadeVisible:(BOOL)visible;

- (id)getView:(NSInteger)tag;

- (instancetype)clearSubviews;

- (instancetype)show;

- (instancetype)hide;

- (UIView *)add:(UIView *)view;

- (instancetype)onClick:(void (^)(UIView *))block;

- (instancetype)onTap:(void (^)(UIView *))block;

- (void)setOnClick:(void (^)(UIView *))block;

- (BOOL)isVisibleToUser;

- (instancetype)aspectFit;

- (instancetype)aspectFill;

- (instancetype)clipToBounds;

- (UIView *)addBottomSeparator:(CGFloat)height;

- (instancetype)asBottomSeparator:(CGFloat)height;

- (instancetype)border:(CGFloat)width color:(UIColor *)color radius:(int)radius;

@end

NS_ASSUME_NONNULL_END
