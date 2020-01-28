//
// Created by Rene Dohan on 17/07/18.
//
@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CSPosition)

@property(readonly) CGPoint position;

@property(readonly) CGFloat x;

@property(readonly) CGFloat y;

@property(readonly) CGFloat leftFromRight;

@property(readonly) CGFloat topFromBottom;

@property(readonly) CGFloat absBottom;

@property(readonly) CGFloat verticalCenter;

@property(readonly) CGFloat horizontalCenter;

@property(nonatomic) CGFloat absTop;

@property(nonatomic) CGFloat left;
@property(nonatomic) CGFloat right;
@property(nonatomic) CGFloat top;
@property(nonatomic) CGFloat bottom;

@property(nonatomic) CGFloat fromRight;
@property(nonatomic) CGFloat fromBottom;

- (instancetype)verticalCenter:(CGFloat)y;

- (instancetype)horizontalCenter:(CGFloat)x;

- (instancetype)center:(CGPoint)point;

- (instancetype)center:(CGFloat)x :(CGFloat)y;

- (instancetype)centerInParent;

- (instancetype)centerInParentVertical;

- (instancetype)centerInParentHorizontal;

@end

NS_ASSUME_NONNULL_END
