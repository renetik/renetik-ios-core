//
//  Created by Rene Dohan on 6/5/12.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN
@interface UIColor (CSExtension)

+(UIColor *)colorWithRGBA:(CGFloat)red :(CGFloat)green :(CGFloat)blue :(CGFloat)alpha;

+(UIColor *)colorWithHex:(NSString *)hex;

//-(UIColor *)addAlpha:(CGFloat) alpha
//    NS_SWIFT_NAME(add(alpha:));
@end
NS_ASSUME_NONNULL_END
