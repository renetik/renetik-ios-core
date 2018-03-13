//
// Created by Rene Dohan on 30/12/14.
// Copyright (c) 2014 creative_studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UINavigationController+CSExtension.h"


@implementation UIToolbar (CSExtension)

- (void)changeText:(UIBarButtonItem *)item :(NSString *)title {
    UIBarButtonItem *replacingItem = [UIBarButtonItem createWithTitle:title :item.style :item.target :item.action];
    [self replaceItem:item by:replacingItem];
}

- (void)changeTextAt:(NSInteger)itemIndex :(NSString *)title {
    UIBarButtonItem *replacedItem = [self.items objectAtIndex:(NSUInteger) itemIndex];
    UIBarButtonItem *itemReplace = [UIBarButtonItem createWithTitle:title :replacedItem.style :replacedItem.target :replacedItem.action];
    [self replaceItem:replacedItem by:itemReplace];
}

- (void)changeItem:(UIBarButtonItem *)item :(UIBarButtonSystemItem)systemItem {
    UIBarButtonItem *replacingItem = [UIBarButtonItem createWithItem:systemItem :item.target :item.action];
    [self replaceItem:item by:replacingItem];
}

- (void)changeItemAt:(NSInteger)itemIndex :(UIBarButtonSystemItem)systemItem {
    UIBarButtonItem *replacedItem = [self.items objectAtIndex:(NSUInteger) itemIndex];
    UIBarButtonItem *replacingItem = [UIBarButtonItem createWithItem:systemItem :replacedItem.target :replacedItem.action];
    [self setItem:replacingItem atIndex:(NSUInteger) itemIndex animated:YES];
}

- (UIBarButtonItem *)replaceItem:(UIBarButtonItem *)replacedItem by:(UIBarButtonItem *)replacingItem {
    return [self setItem:replacingItem atIndex:[self.items indexOfObject:replacedItem] animated:YES];
}

- (UIBarButtonItem *)setItem:(UIBarButtonItem *)item atIndex:(NSUInteger)index {
    [self setItem:item atIndex:index animated:YES];
    return item;
}

- (UIToolbar *)insertItem:(UIBarButtonItem *)item atIndex:(NSUInteger)index {
    [self insertItem:item atIndex:index animated:YES];
    return self;
}

- (UIBarButtonItem *)setItem:(UIBarButtonItem *)item atIndex:(NSUInteger)index animated:(BOOL)animated {
    NSMutableArray *items = [self.items mutableCopy];
    items[index] = item;
    [self setItems:items animated:animated];
    return item;
}

- (void)insertItem:(UIBarButtonItem *)item atIndex:(NSUInteger)index animated:(BOOL)animated {
    NSMutableArray *items = [self.items mutableCopy];
    [items insertObject:item atIndex:index];
    [self setItems:items animated:animated];
}

@end
