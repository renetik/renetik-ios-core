//
// Created by Rene Dohan on 26/05/18.
// Copyright (c) 2018 Renetik Software. All rights reserved.
//

#import "UITextField+CSExtension.h"
#import "UIView+CSExtension.h"

@implementation UITextField (CSExtension)

- (instancetype)setLeftInsetByLeftView:(int)width {
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 1)];
    leftView.backgroundColor = self.backgroundColor;
    self.leftView = [UIView createEmptyWithSize:width :1];
    self.leftViewMode = UITextFieldViewModeAlways;
    return self;
}

- (instancetype)clear {
    [self setText:@""];
    return self;
}

@end