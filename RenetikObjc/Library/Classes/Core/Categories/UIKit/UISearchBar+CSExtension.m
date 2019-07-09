//
// Created by Rene Dohan on 24/01/15.
// Copyright (c) 2015 creative_studio. All rights reserved.
//

#import "UISearchBar+CSExtension.h"


@implementation UISearchBar (CSExtension)

- (void)setTextColor:(UIColor *)textColor {
    for (UIView *subView in self.subviews) {
        for (UIView *secondLevelSubview in subView.subviews) {
            if ([secondLevelSubview isKindOfClass:[UITextField class]]) {
                UITextField *textField = (UITextField *) secondLevelSubview;
                textField.textColor = textColor;
            }
            if ([secondLevelSubview isKindOfClass:[UIButton class]]) {
                UIButton *button = (UIButton *) secondLevelSubview;
                [button setTitleColor:textColor forState:UIControlStateNormal];
                [button setTitleColor:textColor forState:UIControlStateHighlighted];
            }
        }
    }
}


- (void)transparent {
    self.barTintColor = UIColor.clearColor;
    self.backgroundColor = UIColor.clearColor;
}
@end
