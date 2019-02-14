//
// Created by Rene Dohan on 6/26/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "UITapGestureRecognizer+CSExtension.h"


@implementation UITapGestureRecognizer (CSExtension)

- (instancetype)constructForTap:(UIView *)view :(id)target :(SEL)action {
    self.numberOfTapsRequired = 1;
    self.numberOfTouchesRequired = 1;
    [self addTarget:target action:action];
    [view addGestureRecognizer:self];
    return self;
}

@end