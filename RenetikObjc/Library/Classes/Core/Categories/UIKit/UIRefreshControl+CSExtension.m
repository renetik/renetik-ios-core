//
// Created by Rene Dohan on 31/1/17.
// Copyright (c) 2017 Renetik Software. All rights reserved.
//

#import "UIRefreshControl+CSExtension.h"


@implementation UIRefreshControl (CSExtension)

- (UIRefreshControl *)addRefreshControl:(UIScrollView *)control :(id)target :(SEL)action {
    control.alwaysBounceVertical = YES;
//    self.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to refresh"
//                                                           attributes:@{NSForegroundColorAttributeName: UIColor.whiteColor}];
    [self addTarget:target action:action forControlEvents:UIControlEventValueChanged];
    [control addSubview:self];
    return self;
}

@end