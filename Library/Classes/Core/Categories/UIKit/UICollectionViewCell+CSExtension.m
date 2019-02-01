//
// Created by Rene Dohan on 24/11/16.
// Copyright (c) 2016 Renetik Software. All rights reserved.
//

#import "UICollectionViewCell+CSExtension.h"
#import "UIView+CSExtension.h"
#import "NSArray+CSExtension.h"

@implementation UICollectionViewCell (CSExtension)

- (UIView *)cellView {
    return self.contentView.content;
}

@end
