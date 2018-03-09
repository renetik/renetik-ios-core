//
// Created by Rene Dohan on 24/11/16.
// Copyright (c) 2016 Renetik Software. All rights reserved.
//

#import "UICollectionViewCell+CSExtension.h"


@implementation UICollectionViewCell (CSExtension)

- (UIView *)view {
    return self.contentView.subviews[0];
}

@end