//
//  Created by Rene Dohan on 7/15/12.
//


#import <UIKit/UIKit.h>
#import "CALayer+CSExtension.h"


@implementation CALayer (CSExtension)

- (void)setBorder:(CGFloat)width :(UIColor *)color :(int)radius {
    self.borderWidth = width;
    self.borderColor = color.CGColor;
    self.cornerRadius = radius;
    self.masksToBounds = YES;
}

@end