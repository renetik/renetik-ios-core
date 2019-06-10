//
//  Created by Rene Dohan on 1/13/13.
//
@import UIKit;

@interface UIImageView (CSExtension)

- (void)resizableImageWithCapInsets:(UIEdgeInsets)insets;

- (void)stretchableImageWithLeftCapWidth:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight;

@end
