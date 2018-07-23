//
//  Created by Rene Dohan on 4/29/12.
//

#import <UIKit/UIKit.h>

@class MBProgressHUD;

static float const CS_FADE_TIME = 0.3;

@interface UIView (CSExtension)

- (instancetype)contentMode:(UIViewContentMode)contentMode;

- (instancetype)clipsToBounds:(BOOL)clipsToBounds;

+ (void)animate:(NSTimeInterval)duration :(void (^)(void))animations;

+ (instancetype)wrap:(UIView *)view;

+ (instancetype)wrap:(UIView *)view withPadding:(int)padding;

- (instancetype)asCircular;

- (instancetype)clone;

+ (UIViewAnimationOptions)animationOptionsWithCurve:(UIViewAnimationCurve)curve;

- (UIView *)firstResponder;

+ (instancetype)create:(NSString *)IBName;

+ (instancetype)create;

+ (NSString *)NIBName;

+ (void)animationFromCurrentState:(NSTimeInterval)time :(UIViewAnimationCurve)curve;

- (void)fadeIn:(NSTimeInterval)time :(void (^)(void))onDone;

- (void)fadeIn:(NSTimeInterval)time;

+ (instancetype)createEmpty;

+ (instancetype)withColor:(UIColor *)color;

+ (instancetype)withColor:(UIColor *)color frame:(CGRect)frame;

+ (instancetype)withFrame:(CGRect)frame;

+ (instancetype)withSize:(CGFloat)width :(CGFloat)height;

+ (instancetype)withRect:(CGFloat)left :(CGFloat)top :(CGFloat)width :(CGFloat)height;

+ (instancetype)withHeight:(CGFloat)height;

- (instancetype)fadeIn;

- (void)fadeBackgroundColorTo:(UIColor *)color;

- (void)fadeOut:(NSTimeInterval)time;

- (void)fadeOut:(NSTimeInterval)time :(void (^)(void))method;

- (instancetype)setColor:(UIColor *)color;

- (instancetype)color:(UIColor *)color;

- (UIColor *)color;

- (void)fadeOut;

- (void)fadeToggle;

- (void)setVisible:(BOOL)visible;

- (void)setFadeVisible:(BOOL)visible;

- (BOOL)visible;

- (UIViewController *)controller;

- (id)getView:(int)tag;

- (instancetype)clearSubViews;

- (instancetype)show;

- (instancetype)hide;

- (UIView *)addUnderLast:(UIView *)view;

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

- (UIView *)addViewVerticalSingleLineLayout:(UIView *)view offset:(int)offset;

- (UIView *)addViewVerticalSingleLineLayout:(UIView *)view;

- (UIView *)createSeparatorHorizontal:(CGFloat)offset :(CGFloat)height;

- (instancetype)onTap:(void (^)(void))block;

- (void)setOnTap:(void (^)(void))block;

- (BOOL)isVisibleToUser;

- (UIView *)content:(UIView *)view;

- (void)setContent:(UIView *)view;

- (UIView *)content;

- (instancetype)sizeFit;
@end
