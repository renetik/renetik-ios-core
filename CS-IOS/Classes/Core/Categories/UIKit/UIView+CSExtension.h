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

- (void)resizeAutoResizingViewsFonts:(CGFloat)multiply;

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

- (void)setRight:(CGFloat)right;

- (void)setBottom:(CGFloat)bottom;

- (instancetype)setRightToWidth:(CGFloat)right;

- (void)setBottomToHeight:(CGFloat)bottom;

- (instancetype)setHeight:(CGFloat)height;

- (instancetype)setWidth:(CGFloat)width;

- (UIView *)setWidthToLeft:(CGFloat)width;

- (void)setTopToHeight:(CGFloat)top;

- (instancetype)setColor:(UIColor *)color;

- (void)fadeOut;

- (void)fadeToggle;

- (void)setVisible:(BOOL)visible;

- (void)setFadeVisible:(BOOL)visible;

- (BOOL)visible;

- (UIViewController *)controller;

- (id)getView:(int)tag;

@property(readonly) CGFloat top;
@property CGFloat absTop;
@property(readonly) CGFloat absBottom;

- (CGFloat)x;

- (instancetype)setLeft:(CGFloat)value;

- (CGFloat)left;

- (instancetype)setTop:(CGFloat)value;

- (CGFloat)y;

- (CGFloat)height;

- (CGSize)size;

- (void)setSize:(CGSize)size;

- (instancetype)setLeft:(CGFloat)left top:(CGFloat)top;

- (instancetype)setLeft:(CGFloat)left top:(CGFloat)top width:(CGFloat)width height:(CGFloat)height;

- (instancetype)setWidth:(CGFloat)width height:(CGFloat)height;

- (void)setPosition:(CGPoint)position;

- (CGFloat)right;

- (CGFloat)bottom;

- (CGFloat)width;

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

- (instancetype)onTap:(void (^)(void))block;

- (UIView *)addViewUnderLastFilingParent:(UIView *)view;

- (void)removeSubviewsOfClass:(Class)pClass;

- (UIScrollView *)wrapInVerticalScrollView;
@end
