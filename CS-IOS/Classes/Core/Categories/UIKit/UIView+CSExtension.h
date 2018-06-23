//
//  Created by Rene Dohan on 4/29/12.
//

#import <UIKit/UIKit.h>

@class MBProgressHUD;

static float const CS_FADE_TIME = 0.3;

@interface UIView (CSExtension)

+ (void)hide:(NSArray<UIView *> *)array;

- (UIButton *)addFloatingButton:(UIImage *)image :(void (^)(UIButton *))onClick;

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

+ (instancetype)createEmptyWithRect:(CGFloat)left :(CGFloat)top :(CGFloat)width :(CGFloat)height;

+ (instancetype)createEmptyWithHeight:(CGFloat)height;

- (instancetype)fadeIn;

- (void)fadeBackgroundColorTo:(UIColor *)color;

- (void)fadeOut:(NSTimeInterval)time;

- (void)fadeOut:(NSTimeInterval)time :(void (^)(void))method;

- (void)setRight:(float)right;

- (void)setBottom:(float)bottom;

- (instancetype)setRightToWidth:(float)right;

- (void)setBottomToHeight:(float)bottom;

- (instancetype)setHeight:(float)height;

- (instancetype)setWidth:(float)width;

- (UIView *)setWidthToLeft:(float)width;

- (void)setTopToHeight:(float)top;

- (instancetype)setColor:(UIColor *)color;

- (void)fadeOut;

- (void)fadeToggle;

- (void)setVisible:(BOOL)visible;

- (void)setFadeVisible:(BOOL)visible;

- (BOOL)visible;

- (UIViewController *)controller;

- (id)getView:(int)tag;

@property(readonly) float top;
@property float absTop;
@property(readonly) float absBottom;

- (float)x;

- (instancetype)setLeft:(float)value;

- (float)left;

- (instancetype)setTop:(float)value;

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

- (instancetype)addViews:(NSArray<UIView *> *)views;

- (UIView *)addView:(UIView *)view :(NSInteger)index;

- (UIView *)setView:(UIView *)view :(NSInteger)index;

- (UIView *)positionViewUnderLast:(UIView *)view;

- (UIView *)addViewNextLast:(UIView *)view;

- (UIView *)addViewNextLastFilingParent:(UIView *)view;

- (UIView *)positionViewNextLast:(UIView *)view;

- (void)resizeByTop:(CGFloat)y;

- (instancetype)matchParent;

- (instancetype)autoResizingWidthHeight;

- (instancetype)autoResizingWidth;

- (instancetype)autoResizingHeight;

- (instancetype)flexibleBottom;

- (instancetype)flexibleTop;

- (instancetype)flexibleLeft;

- (instancetype)flexibleRight;

- (instancetype)autoResizingRightAndBottom;

- (instancetype)autoResizingLeftAndBottom;

- (instancetype)autoResizingRightAndTop;

- (instancetype)autoResizingLeftAndTop;

- (UIView *)centerInParent;

- (instancetype)centerInParentVertical;

- (instancetype)matchParentHeight;

- (instancetype)matchParentWidth;

- (instancetype)matchParentWidthInset:(int)inset;

- (UIView *)addViewHorizontalSingleLineLayout:(UIView *)view;

- (UIView *)addViewHorizontalLayout:(UIView *)view;

- (UIView *)addViewHorizontalSingleLineReverseLayout:(UIView *)view;

- (UIView *)addViewHorizontalReverseLayout:(UIView *)view;

- (UIView *)addViewVerticalLayout:(UIView *)view;

- (UIView *)addViewVerticalSingleLineLayout:(UIView *)view offset:(int)offset;

- (UIView *)addViewVerticalSingleLineLayout:(UIView *)view;

- (UIView *)createSeparatorHorizontal:(CGFloat)offset :(CGFloat)height;

- (UIView *)addViewUnderLastFilingParent:(UIView *)view;

- (void)removeSubviewsOfClass:(Class)pClass;

@end
