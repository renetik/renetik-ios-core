//
// Created by Rene Dohan on 26/05/18.
// Copyright (c) 2018 Renetik Software. All rights reserved.
//

#import "UISegmentedControl+CSExtension.h"

@implementation UISegmentedControl (CSExtension)
- (NSString *)selectedTitle {
    return self.selectedSegmentIndex != UISegmentedControlNoSegment ?
            [self titleForSegmentAtIndex:(NSUInteger) self.selectedSegmentIndex] : nil;
}

+ (int)DEFAULT_HEIGHT {
    return 28;
}

- (NSInteger)selectedIndex {
    return self.selectedSegmentIndex;
}

- (void)setSelectedIndex:(NSInteger)index {
    self.selectedSegmentIndex = index;
}
@end