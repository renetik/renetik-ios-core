//
// Created by Rene Dohan on 17/07/18.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface UIView (CSDimension)

- (instancetype)size:(CGSize)size;

- (instancetype)setSize:(CGSize)size;

- (instancetype)width:(CGFloat)width height:(CGFloat)height;

- (void)setWidth:(CGFloat)width;

- (instancetype)width:(CGFloat)value;

- (instancetype)widthFromRight:(CGFloat)width;

- (instancetype)matchParentWidth;

- (instancetype)matchParentWidthWithMargin:(CGFloat)margin;

- (instancetype)matchParentHeightWithMargin:(CGFloat)margin;

- (void)setHeight:(CGFloat)height;

- (instancetype)height:(CGFloat)height;

- (instancetype)matchParentHeight;

- (instancetype)matchParent;

- (instancetype)matchParentWithMargin:(CGFloat)margin;

- (instancetype)addWidth:(CGFloat)value;

- (instancetype)addHeight:(CGFloat)value;

- (instancetype)sizeFit;

- (instancetype)sizeFitHeight;

- (instancetype)fitSubviews;

- (instancetype)contentMarging:(CGFloat)padding;

- (instancetype)contentMargingVertical:(CGFloat)padding;

- (instancetype)contentMargingHorizontal:(CGFloat)padding;

- (instancetype)padding:(CGFloat)padding;

- (instancetype)addLeft:(int)value;

- (instancetype)addTop:(int)value;

- (instancetype)addRight:(int)value;

- (instancetype)addBottom:(int)value;

@end
NS_ASSUME_NONNULL_END
