//
// Created by Rene Dohan on 13/01/15.
// Copyright (c) 2015 creative_studio. All rights reserved.
//

#import "UIBarButtonItem+CSExtension.h"


@implementation UIBarButtonItem (CSExtension)

+ (UIBarButtonItem *)createSoloTitle:(NSString *)title {
    return [UIBarButtonItem.alloc initWithTitle:title style:UIBarButtonItemStylePlain target:nil action:nil];
}

+ (UIBarButtonItem *)createWithTitle:(NSString *)title :(UIBarButtonItemStyle)style :(id)target :(SEL)action {
    return [UIBarButtonItem.alloc initWithTitle:title style:style target:target action:action];
}

+ (UIBarButtonItem *)createWithItem:(UIBarButtonSystemItem)item :(id)target :(SEL)action {
    return [UIBarButtonItem.alloc initWithBarButtonSystemItem:item target:target action:action];
}

+ (UIBarButtonItem *)createWithItem:(UIBarButtonSystemItem)item{
    return [UIBarButtonItem.alloc initWithBarButtonSystemItem:item target:nil action:nil];
}

+ (UIBarButtonItem *)createSpaceItem:(UIBarButtonSystemItem)item {
    return [UIBarButtonItem.alloc initWithBarButtonSystemItem:item target:nil action:nil];
}

- (void)setTarget:(id)target forAction:(SEL)action {
    self.target = target;
    self.action = action;
}

@end
