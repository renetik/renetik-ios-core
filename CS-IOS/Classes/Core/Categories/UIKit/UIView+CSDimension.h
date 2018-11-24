//
// Created by Rene Dohan on 17/07/18.
//

#import <Foundation/Foundation.h>

@interface UIView (CSDimension)
- (CGSize)size;

- (instancetype)size:(CGSize)size;

- (instancetype)setSize:(CGSize)size;

- (CGFloat)width;

- (instancetype)width:(CGFloat)width height:(CGFloat)height;

- (void)setWidth:(CGFloat)width;

- (instancetype)width:(CGFloat)value;

- (void)setWidthFromRight:(CGFloat)width;

- (instancetype)widthFromRight:(CGFloat)width;

- (instancetype)matchParentWidth;

- (instancetype)matchParentWidthWithMargin:(CGFloat)margin;

- (instancetype)matchParentHeightWithMargin:(CGFloat)margin;

- (CGFloat)height;

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

- (CGSize)calculateSizeFromSubviews;

- (instancetype)contentPadding:(CGFloat)padding;

- (instancetype)contentPaddingVertical:(CGFloat)padding;

- (instancetype)contentPaddingHorizontal:(CGFloat)padding;

- (instancetype)addMargin:(CGFloat)margin;
@end