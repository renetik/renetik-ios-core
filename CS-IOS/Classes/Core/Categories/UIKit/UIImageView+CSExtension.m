//
//  Created by Rene Dohan on 1/13/13.
//
#import "NSObject+CSExtension.h"
#import "UIImageView+CSExtension.h"
#import "UIView+CSExtension.h"

@implementation UIImageView (CSExtension)

- (instancetype)construct {
    super.construct;
    self.clipsToBounds = YES;
    [self contentMode:UIViewContentModeScaleAspectFit];
    return self;
}

- (void)resizableImageWithCapInsets:(UIEdgeInsets)insets {
    self.image = [self.image resizableImageWithCapInsets:insets];
}

- (instancetype)setPicture:(UIImage *)image {
    self.image = image;
    return self;
}

- (instancetype)image:(UIImage *)image {
    self.image = image;
    return self;
}

- (void)stretchableImageWithLeftCapWidth:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight {
    self.image = [self.image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
}



@end
