//
// Created by Rene Dohan on 17/07/18.
//
@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CSPosition)

@property(readonly) CGPoint position;
@property(readonly) CGFloat x;
@property(readonly) CGFloat y;
@property(nonatomic) CGFloat left;
@property(nonatomic) CGFloat right;
@property(nonatomic) CGFloat top;
@property(nonatomic) CGFloat bottom;

- (instancetype)position:(CGPoint)point;

- (instancetype)center:(CGPoint)point;

- (instancetype)center:(CGFloat)x :(CGFloat)y;

//- (instancetype)centerInParent;
//
//- (instancetype)centerInParentVertical;
//
//- (instancetype)centerInParentHorizontal;

@end

NS_ASSUME_NONNULL_END
