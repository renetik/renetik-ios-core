//
// Created by inno on 1/28/13.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import <UIKit/UIKit.h>

@interface UIButton (CSExtension)

- (void)stretchableBackgroundImageWithLeftCapWidth:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight;

+ (UIButton *)createWithFrame:(CGRect)rect image:(UIImage *)image contentMode:(UIViewContentMode)mode;

- (void)setTitleColor:(UIColor *)color;

- (instancetype)setTitle:(NSString *)title;

- (NSString *)title;

- (instancetype)setPicture:(UIImage *)image;

- (void)setBackgroundImage:(UIImage *)image;
@end