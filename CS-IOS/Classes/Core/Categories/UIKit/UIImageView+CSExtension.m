//
//  Created by Rene Dohan on 1/13/13.
//
#import "CSLang.h"
#import "UIImageView+CSExtension.h"

@implementation UIImageView (CSExtension)

- (void)resizableImageWithCapInsets:(UIEdgeInsets)insets {
    self.image = [self.image resizableImageWithCapInsets:insets];
}

- (void)stretchableImageWithLeftCapWidth:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight {
    self.image = [self.image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
}

@end