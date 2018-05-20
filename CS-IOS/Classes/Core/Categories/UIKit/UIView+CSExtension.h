//
//  Created by Rene Dohan on 4/29/12.
//

#import <UIKit/UIKit.h>

@class MBProgressHUD;

static float const CS_FADE_TIME = 0.3;

@interface UIView (CSExtension)

+ (void)hide:(NSArray<UIView *> *)array;

- (instancetype)clone;

- (void)resizeAutoResizingViewsFonts:(float)multiply;

+ (UIView *)findFirstResponder:(UIView *)view;

+ (UIViewAnimationOptions)animationOptionsWithCurve:(UIViewAnimationCurve)curve;

- (UIView *)firstResponder;

+ (instancetype)create:(NSString *)IBName;

+ (instancetype)create;

+ (NSString *)NIBName;

+ (void)animationFromCurrentState:(NSTimeInterval)time :(UIViewAnimationCurve)curve;

- (void)fadeIn:(NSTimeInterval)time :(void (^)(void))onDone;

- (void)fadeIn:(NSTimeInterval)time;

+ (instancetype)createEmpty;

+ (instancetype)createEmptyWithColor:(UIColor *)color;

+ (instancetype)createEmptyWithColor:(UIColor *)color frame:(CGRect)frame;

+ (instancetype)createEmptyWithFrame:(CGRect)frame;

+ (instancetype)createEmptyWithSize:(CGFloat)width :(CGFloat)height;

- (instancetype)fadeIn;

- (void)fadeBackgroundColorTo:(UIColor *)color;

- (void)fadeOut:(NSTimeInterval)time;

- (void)fadeOut:(NSTimeInterval)time :(void (^)(void))method;

- (void)setRight:(float)right;

- (void)setBottom:(float)bottom;

- (void)setRightToWidth:(float)right;

- (void)setBottomToHeight:(float)bottom;

- (instancetype)setHeight:(float)height;

- (instancetype)setWidth:(float)width;

- (UIView *)setWidthToLeft:(float)width;

- (void)setTopToHeight:(float)top;

- (void)fadeOut;

- (void)fadeToggle;

- (void)setVisible:(BOOL)visible;

- (void)setFadeVisible:(BOOL)visible;

- (BOOL)visible;

- (UIViewController *)controller;

- (id)getView:(int)tag;

@property float left;
@property float top;
@property float absTop;
@property(readonly) float absBottom;

- (float)x;

- (float)y;

- (float)height;

- (CGSize)size;

- (void)setSize:(CGSize)size;

- (void)setPosition:(CGPoint)position;

- (float)right;

- (float)bottom;

- (float)width;

- (instancetype)clearSubViews;

- (instancetype)show;

- (instancetype)hide;

- (UIView *)addViewUnderLast:(UIView *)view;

- (UIView *)addView:(UIView *)view;

- (UIView *)addView:(UIView *)view :(NSInteger)index;

- (UIView *)setView:(UIView *)view :(NSInteger)index;

- (UIView *)positionViewUnderLast:(UIView *)view;

- (UIView *)addViewNextLast:(UIView *)view;

- (UIView *)addViewNextLastFilingParent:(UIView *)view;

- (UIView *)positionViewNextLast:(UIView *)view;

- (void)resizeByTop:(CGFloat)y;

- (instancetype)matchParent;

- (UIView *)centerInParent;

- (instancetype)matchParentHeight;

- (instancetype)flexibleHeight;

- (instancetype)matchParentWidth;

- (UIView *)addViewHorizontalSingleLineLayout:(UIView *)view;

- (UIView *)addViewHorizontalLayout:(UIView *)view;

- (UIView *)addViewHorizontalSingleLineReverseLayout:(UIView *)view;

- (UIView *)addViewHorizontalReverseLayout:(UIView *)view;

- (UIView *)addViewVerticalLayout:(UIView *)view;

- (UIView *)addViewUnderLastFilingParent:(UIView *)view;

- (void)removeSubviewsOfClass:(Class)pClass;
@end
