//
//  Created by Rene Dohan on 7/15/12.
//


#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@class UIColor;

@interface CALayer (CSExtension)

- (void)setBorder:(CGFloat)width :(UIColor *)color :(int)radius;

@end