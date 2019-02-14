//
// Created by Rene Dohan on 20/11/13.
// Copyright (c) 2013 creative_studio. All rights reserved.
//

#import "CSTextField.h"

@implementation CSTextField {

}

- (CGRect)caretRectForPosition:(UITextPosition *)position {
    return self.hideCursor ? CGRectZero : [super caretRectForPosition:position];
}

@end
