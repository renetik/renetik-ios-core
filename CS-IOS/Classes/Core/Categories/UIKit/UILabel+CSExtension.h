//
// Created by Rene Dohan on 02/12/14.
// Copyright (c) 2014 creative_studio. All rights reserved.
//

@import UIKit;


@interface UILabel (CSExtension)
- (instancetype)setString:(NSString *)text;

- (instancetype)setFontSize:(CGFloat)size;

- (void)setHTMLFromString:(NSString *)string;
@end
