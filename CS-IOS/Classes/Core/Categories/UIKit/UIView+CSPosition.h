//
// Created by Rene Dohan on 17/07/18.
//

#import <Foundation/Foundation.h>

@interface UIView (CSPosition)
- (CGPoint)position;

- (instancetype)position:(CGPoint)position;

- (instancetype)left:(CGFloat)value;

- (CGFloat)left;

- (void)setLeft:(int)left;

- (CGFloat)x;

- (instancetype)left:(CGFloat)left top:(CGFloat)top;

- (instancetype)left:(CGFloat)left top:(CGFloat)top width:(CGFloat)width height:(CGFloat)height;

- (CGFloat)right;

- (CGFloat)fromRight;

- (CGFloat)leftFromRight;

- (CGFloat)topFromBottom;

- (instancetype)fromRight:(CGFloat)right;

- (void)setFromRight:(CGFloat)value;

- (instancetype)rightToWidth:(CGFloat)right;

- (instancetype)fromRightToWidth:(CGFloat)lengthFromRight;

- (instancetype)fromBottomToHeight:(CGFloat)lengthFromBottom;

- (CGFloat)top;

- (CGFloat)y;

- (instancetype)top:(CGFloat)value;

- (void)setTop:(CGFloat)value;

- (instancetype)verticalCenter:(CGFloat)y;

- (instancetype)horizontalCenter:(CGFloat)x;

- (instancetype)center:(CGPoint)point;

- (instancetype)center:(CGFloat)x :(CGFloat)y;

- (CGFloat)absTop;

- (void)setAbsTop:(float)value;

- (instancetype)bottomToHeight:(CGFloat)bottom;

- (instancetype)topToHeight:(CGFloat)top;

- (instancetype)fromBottom:(CGFloat)bottom;

- (void)setFromBottom:(CGFloat)bottom;

- (CGFloat)bottom;

- (void)setBottom:(CGFloat)value;

- (instancetype)bottom:(CGFloat)value;

- (void)setRight:(CGFloat)value;

- (instancetype)right:(CGFloat)value;

- (CGFloat)fromBottom;

- (CGFloat)absBottom;

- (UIView *)centerInParent;

- (instancetype)centerInParentVertical;

- (instancetype)centerInParentHorizontal;
@end