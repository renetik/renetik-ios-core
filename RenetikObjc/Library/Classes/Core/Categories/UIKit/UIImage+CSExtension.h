//
//  Created by Rene Dohan on 10/14/12.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN
@interface UIImage (CSExtension)

+ (UIImage *)imageWithColor:(UIColor *)color;

- (UIImage *)inverseColor;

- (UIImage *)scaleAndRotateFromCamera:(int)maxResolution;

@end
NS_ASSUME_NONNULL_END