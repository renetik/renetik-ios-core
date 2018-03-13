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


- (void)makeTransparent {
    if (([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] == NSOrderedAscending)) {
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(1, 1), NO, 0.0);
        UIImage *blank = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        self.backgroundImage = blank;
        self.backgroundColor = [UIColor clearColor];
    } else {
        self.barTintColor = [UIColor clearColor];
    }
}
@end
