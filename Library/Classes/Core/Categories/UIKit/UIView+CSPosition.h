//
// Created by Rene Dohan on 17/07/18.
//
@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CSPosition)

- (void)setLeft:(int)left;

- (void)setFromRight:(CGFloat)value;

- (void)setTop:(CGFloat)value;

- (instancetype)verticalCenter:(CGFloat)y;

- (instancetype)horizontalCenter:(CGFloat)x;

- (instancetype)center:(CGPoint)point;

- (instancetype)center:(CGFloat)x :(CGFloat)y;

- (void)setAbsTop:(float)value;

- (void)setFromBottom:(CGFloat)bottom;

- (void)setBottom:(CGFloat)value;

- (void)setRight:(CGFloat)value;

- (instancetype)centerInParent;

- (instancetype)centerInParentVertical;

- (instancetype)centerInParentHorizontal;

@end

NS_ASSUME_NONNULL_END
