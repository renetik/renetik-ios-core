//
// Created by Rene Dohan on 17/07/18.
//
@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CSLayoutGetters)

- (CGPoint)position;

- (CGFloat)left;

- (CGFloat)x;

- (CGFloat)top;

- (CGFloat)y;

- (CGFloat)right;

- (CGFloat)bottom;

- (CGFloat)fromRight;

- (CGFloat)fromBottom;

- (CGFloat)leftFromRight;

- (CGFloat)topFromBottom;

- (CGFloat)absTop;

- (CGFloat)absBottom;

- (CGSize)size;

- (CGFloat)width;

- (CGFloat)height;

- (CGSize)calculateSizeFromSubviews;

@end

NS_ASSUME_NONNULL_END