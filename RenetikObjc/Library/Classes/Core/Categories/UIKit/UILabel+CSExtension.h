//
// Created by Rene Dohan on 02/12/14.
// Copyright (c) 2014 creative_studio. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN
@interface UILabel (CSExtension)

- (instancetype)setFontSize :(CGFloat)size;

- (instancetype)fontSize :(CGFloat)size;

- (void)setFontStyle :(UIFontTextStyle)style;

- (instancetype)fontStyle :(UIFontTextStyle)style;

- (instancetype)font :(UIFont *)font;

- (instancetype)textColor :(UIColor *)textColor;

- (instancetype)setHTMLFromString :(NSString *)string;

- (instancetype)hideIfEmpty;

- (instancetype)sizeHeightToLines :(NSInteger)numberOfLines;

- (instancetype)sizeFitHeight;

- (CGSize)sizeThatFitWidth :(NSInteger)width;

- (instancetype)sizeFit :(NSString *)value;

- (instancetype)text :(NSString *)string;

- (instancetype)textAlign :(enum NSTextAlignment)alignment;
@end
NS_ASSUME_NONNULL_END
