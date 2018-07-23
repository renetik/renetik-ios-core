//
//  Created by Rene Dohan on 1/13/13.
//

#import <UIKit/UIKit.h>

@interface UIImageView (CSExtension)

- (instancetype)setPicture:(UIImage *)image;

- (void)resizableImageWithCapInsets:(UIEdgeInsets)insets;

- (instancetype)image:(UIImage *)image;

- (void)stretchableImageWithLeftCapWidth:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight;

@end