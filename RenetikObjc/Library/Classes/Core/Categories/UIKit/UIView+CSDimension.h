//
// Created by Rene Dohan on 17/07/18.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CSDimension)

@property (readonly) CGSize size;

@property (readonly) CGSize calculateSizeFromSubviews;

@property (nonatomic) CGFloat width;

@property (nonatomic) CGFloat height;

- (instancetype)size :(CGSize)size;

- (instancetype)frame :(CGRect)rect;

- (instancetype)setSize :(CGSize)size;

- (instancetype)width :(CGFloat)width height :(CGFloat)height;

- (instancetype)width :(CGFloat)value;

- (instancetype)widthAsHeight;

- (instancetype)height :(CGFloat)height;

- (instancetype)heightAsWidth;

- (instancetype)addWidth :(CGFloat)value;

- (instancetype)addHeight :(CGFloat)value;

- (instancetype)sizeFit;

- (instancetype)sizeFitHeight;

- (instancetype)fitSubviews;

- (instancetype)resizeByPadding :(CGFloat)padding;

- (instancetype)addLeft :(CGFloat)value;

- (instancetype)addTop :(CGFloat)value;

- (instancetype)addRight :(CGFloat)value;

- (instancetype)addBottom :(CGFloat)value;

@end

NS_ASSUME_NONNULL_END
