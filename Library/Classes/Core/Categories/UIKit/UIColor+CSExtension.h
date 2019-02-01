//
//  Created by Rene Dohan on 6/5/12.
//

@import UIKit;

@interface UIColor (CSExtension)

+ (UIColor *)colorWithRGBA:(CGFloat)red :(CGFloat)green :(CGFloat)blue :(CGFloat)alpha;

+ (UIColor *)colorWithHex:(NSString *)hex;

- (UIColor *)addAlpha:(CGFloat)alpha;
@end
