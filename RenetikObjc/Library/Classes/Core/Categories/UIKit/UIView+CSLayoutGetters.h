//
// Created by Rene Dohan on 17/07/18.
//
@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CSLayoutGetters)

@property (readonly) CGPoint position;

@property (readonly) CGFloat left;

@property (readonly) CGFloat x;

@property (readonly) CGFloat top;

@property (readonly) CGFloat y;

@property (readonly) CGFloat right;

@property (readonly) CGFloat bottom;

@property (readonly) CGFloat fromRight;

@property (readonly) CGFloat fromBottom;

@property (readonly) CGFloat leftFromRight;

@property (readonly) CGFloat topFromBottom;

@property (readonly) CGFloat absTop;

@property (readonly) CGFloat absBottom;

@property (readonly) CGSize size;

@property (readonly) CGFloat width;

@property (readonly) CGFloat height;

@property (readonly) CGSize calculateSizeFromSubviews;

@property (readonly) CGFloat verticalCenter;

@property (readonly) CGFloat horizontalCenter;

@end

NS_ASSUME_NONNULL_END
