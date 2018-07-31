//
// Created by inno on 1/28/13.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import <UIKit/UIKit.h>

@interface UIButton (CSExtension)

- (void)stretchableBackgroundImageWithLeftCapWidth:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight;

+ (instancetype)addFloating:(UIView *)view :(UIImage *)image :(void (^)(UIButton *))onClick;

- (void)setTitleColor:(UIColor *)color;

- (instancetype)setTitle:(NSString *)title;

- (NSString *)title;

- (instancetype)image:(UIImage *)image;

- (void)setImage:(UIImage *)image;

- (void)setBackgroundImage:(UIImage *)image;
@end