//
// Created by Rene Dohan on 17/07/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CSPosition)

- (instancetype)position:(CGPoint)position;

- (instancetype)left:(CGFloat)value;

- (void)setLeft:(int)left;

- (instancetype)left:(CGFloat)left top:(CGFloat)top;

- (instancetype)left:(CGFloat)left top:(CGFloat)top width:(CGFloat)width height:(CGFloat)height;

- (instancetype)fromRight:(CGFloat)right;

- (void)setFromRight:(CGFloat)value;

- (instancetype)rightToWidth:(CGFloat)right;

- (instancetype)leftToWidth:(CGFloat)left;

- (instancetype)fromRightToWidth:(CGFloat)lengthFromRight;

- (instancetype)fromBottomToHeight:(CGFloat)lengthFromBottom;

- (instancetype)top:(CGFloat)value;

- (void)setTop:(CGFloat)value;

- (instancetype)verticalCenter:(CGFloat)y;

- (instancetype)horizontalCenter:(CGFloat)x;

- (instancetype)center:(CGPoint)point;

- (instancetype)center:(CGFloat)x :(CGFloat)y;

- (void)setAbsTop:(float)value;

- (instancetype)bottomToHeight:(CGFloat)bottom;

- (instancetype)topToHeight:(CGFloat)top;

- (instancetype)fromBottom:(CGFloat)bottom;

- (void)setFromBottom:(CGFloat)bottom;

- (void)setBottom:(CGFloat)value;

- (instancetype)bottom:(CGFloat)value;

- (void)setRight:(CGFloat)value;

- (instancetype)right:(CGFloat)value;

- (instancetype)centerInParent;

- (instancetype)centerInParentVertical;

- (instancetype)centerInParentHorizontal;

@end

NS_ASSUME_NONNULL_END
