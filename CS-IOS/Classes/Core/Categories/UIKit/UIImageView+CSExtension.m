//
//  Created by Rene Dohan on 1/13/13.
//
#import "UIImageView+CSExtension.h"

@implementation UIImageView (CSExtension)

- (void)resizableImageWithCapInsets:(UIEdgeInsets)insets {
    self.image = [self.image resizableImageWithCapInsets:insets];
}

- (instancetype)setPicture:(UIImage *)image {
    self.image = image;
    return self;
}

- (void)stretchableImageWithLeftCapWidth:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight {
    self.image = [self.image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
}

@end
