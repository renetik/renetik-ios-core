//
// Created by Rene Dohan on 11/11/13.
// Copyright (c) 2013 creative_studio. All rights reserved.
//


#import "CSTableView.h"


@implementation CSTableView {

}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    self.allowsMultipleSelectionDuringEditing = editing;
    [super setEditing:editing animated:animated];
}

@end
