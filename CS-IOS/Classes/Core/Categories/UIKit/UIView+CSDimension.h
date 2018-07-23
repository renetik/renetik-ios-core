//
// Created by Rene Dohan on 17/07/18.
//

#import <Foundation/Foundation.h>

@interface UIView (CSDimension)
- (CGSize)size;

- (instancetype)size:(CGSize)size;

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

- (instancetype)addWidth:(int)value;

- (instancetype)addHeight:(int)value;
@end