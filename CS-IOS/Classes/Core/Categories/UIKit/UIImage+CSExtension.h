//
//  Created by Rene Dohan on 10/14/12.
//


#import <Foundation/Foundation.h>

@interface UIImage (CSExtension)

+ (UIImage *)imageWithColor:(UIColor *)color;

- (UIImage *)inverseColor;

- (UIImage *)scaleAndRotateFromCamera:(int)maxResolution;

- (UIImage *)scaleToWidth:(float)width;

- (UIImage *)scaleToHeight:(float)height;
@end