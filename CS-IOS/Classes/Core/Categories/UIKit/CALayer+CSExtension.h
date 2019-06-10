//
//  Created by Rene Dohan on 7/15/12.
//

@import QuartzCore;

@class UIColor;

@interface CALayer (CSExtension)

- (void)setBorder:(CGFloat)width :(UIColor *)color :(int)radius;

@end
