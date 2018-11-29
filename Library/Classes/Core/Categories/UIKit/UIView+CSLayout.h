//
// Created by Rene on 11/25/18.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UIView (CSLayout)

- (instancetype)left:(CGFloat)value;

- (instancetype)top:(CGFloat)value;

- (instancetype)right:(CGFloat)value;

- (instancetype)bottom:(CGFloat)value;

- (instancetype)left:(CGFloat)left top:(CGFloat)top;

- (instancetype)position:(CGPoint)position;

- (instancetype)left:(CGFloat)left top:(CGFloat)top width:(CGFloat)width height:(CGFloat)height;

- (instancetype)leftToWidth:(CGFloat)left;

- (instancetype)rightToWidth:(CGFloat)right;

- (instancetype)topToHeight:(CGFloat)top;

- (instancetype)bottomToHeight:(CGFloat)bottom;

- (instancetype)fromRight:(CGFloat)value;

- (instancetype)fromBottom:(CGFloat)bottom;

- (instancetype)fromRightToWidth:(CGFloat)lengthFromRight;

- (instancetype)fromBottomToHeight:(CGFloat)lengthFromBottom;

- (instancetype)widthFromRight:(CGFloat)width;

- (instancetype)heightFromBottom:(CGFloat)value;

- (instancetype)matchParent;

- (instancetype)matchParentWithMargin:(CGFloat)margin;

- (instancetype)matchParentWidth;

- (instancetype)matchParentWidthWithMargin:(CGFloat)margin;

- (instancetype)matchParentHeightWithMargin:(CGFloat)margin;

- (instancetype)matchParentHeight;

@end
NS_ASSUME_NONNULL_END
