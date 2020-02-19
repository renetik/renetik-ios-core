//
// Created by Rene Dohan on 17/07/18.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CSAutoResizing)

- (instancetype)setAutoresizingDefaults;

- (instancetype)flexibleWidthHeight;

- (instancetype)flexibleWidth;

- (instancetype)fixedWidth;

- (instancetype)flexibleHeight;

- (instancetype)fixedHeight;

- (instancetype)flexibleBottom;

- (instancetype)fixedRight;

- (instancetype)fixedLeft;

- (instancetype)fixedBottom;

- (instancetype)fixedTop;

- (instancetype)flexibleTop;

- (instancetype)flexibleLeft;

- (instancetype)flexibleRight;

- (instancetype)flexibleLeftTop;

- (instancetype)flexibleLeftBottom;

- (BOOL)isFixedLeft;

- (BOOL)isFixedTop;

- (BOOL)isFixedRight;

- (BOOL)isFixedBottom;

@end

NS_ASSUME_NONNULL_END
