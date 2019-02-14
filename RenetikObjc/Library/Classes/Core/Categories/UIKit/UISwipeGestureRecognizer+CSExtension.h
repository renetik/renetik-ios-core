//
//  Created by Rene Dohan on 10/24/12.
//
@import UIKit;

@class CSSelector;

@interface UISwipeGestureRecognizer (CSExtension)

+ (UISwipeGestureRecognizer *)new:(id)target :(SEL)selector :(UISwipeGestureRecognizerDirection)direction;

@end
