//
// Created by Rene Dohan on 19/02/18.
// Copyright (c) 2018 renetik_software. All rights reserved.
//

#import "UIScreen+CSExtension.h"


@implementation UIScreen (CSExtension)
+ (CGFloat)height {
    return UIScreen.mainScreen.bounds.size.height;
}

+ (CGFloat)width {
    return UIScreen.mainScreen.bounds.size.width;
}
@end