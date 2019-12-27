//
//  Created by Rene Dohan on 10/24/12.
//

#import "UISwipeGestureRecognizer+CSExtension.h"

@implementation UISwipeGestureRecognizer (CSExtension)
+ (UISwipeGestureRecognizer *)new:(id)target :(SEL)selector :(UISwipeGestureRecognizerDirection)direction {
    UISwipeGestureRecognizer *recognizer =
            [[UISwipeGestureRecognizer alloc] initWithTarget:target action:selector];
    [recognizer setDirection:direction];
    return recognizer;
}
@end