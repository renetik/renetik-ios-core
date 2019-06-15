//
// Created by Rene Dohan on 9/10/13.
// Copyright (c) 2013 creative_studio. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import "NSNotification+CSExtension.h"

@implementation NSNotification (CSExtension)
- (CGFloat)keyboardHeight {
    CGRect keyboardFrame = [self.userInfo[UIKeyboardFrameEndUserInfoKey]  CGRectValue];
    return keyboardFrame.size.height;
}

@end
