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
                UITextField *searchBarTextField = (UITextField *) secondLevelSubview;
                searchBarTextField.textColor = textColor;
            }
            if ([subView isKindOfClass:[UIButton class]]) {
                UIButton *cancelButton = (UIButton *) subView;
                [cancelButton setTitleColor:textColor forState:UIControlStateNormal];
                [cancelButton setTitleColor:textColor forState:UIControlStateHighlighted];
            }
        }
    }
}


- (void)transparent {
    self.barTintColor = UIColor.clearColor;
    self.backgroundColor = UIColor.clearColor;
}
@end
