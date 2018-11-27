//
// Created by Rene Dohan on 24/11/16.
// Copyright (c) 2016 Renetik Software. All rights reserved.
//

#import "UICollectionViewCell+CSExtension.h"
#import "NSArray+CSExtension.h"

@implementation UICollectionViewCell (CSExtension)

- (UIView *)content {
    return self.contentView.subviews.last;
}

@end