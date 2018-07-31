//
//  Created by Rene Dohan on 1/13/13.
//

#import <UIKit/UIKit.h>

@interface UIImageView (CSExtension)

- (void)resizableImageWithCapInsets:(UIEdgeInsets)insets;

- (instancetype)image:(UIImage *)image;

- (void)stretchableImageWithLeftCapWidth:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight;

@end