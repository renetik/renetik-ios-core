//
// Created by Rene Dohan on 9/7/13.
// Copyright (c) 2013 creative_studio. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import "CSActionSheet.h"
#import "NSMutableArray+CSExtension.h"
#import "CSLang.h"
#import "NSArray+CSExtension.h"
#import "UIDevice+CSExtension.h"

@implementation CSActionSheet {
    NSString *_title;
    NSString *_cancel;
    NSString *_destructiveTitle;

    void (^_onDestructive)(void);

    NSMutableArray *_titles;
    NSMutableArray *_actions;

    void (^_singleAction)(NSInteger);
}

- (instancetype)init {
    if (self == super.init) {
        _titles = NSMutableArray.new;
        _actions = NSMutableArray.new;
    }
    return self;
}

- (instancetype)title:(NSString *)title {
    _title = title;
    return self;
}

- (instancetype)cancel:(NSString *)cancel {
    _cancel = cancel;
    return self;
}

- (instancetype)destructive:(NSString *)title :(void (^)(void))onDestructive {
    _destructiveTitle = title;
    _onDestructive = [onDestructive copy];
    return self;
}

- (instancetype)onDestructive:(void (^)(void))onDestructive {
    _onDestructive = [onDestructive copy];
    return self;
}

- (instancetype)actions:(NSArray *)titles :(NSArray *)actions {
    [_titles addObjectsFromArray:titles];
    [_actions addObjectsFromArray:[actions copy]];
    return self;
}

- (instancetype)actions:(NSArray *)titles for:(void (^)(NSInteger))action {
    [_titles addObjectsFromArray:titles];
    _singleAction = [action copy];
    return self;
}

- (instancetype)addAction:(NSString *)title :(void (^)(void))action {
    [_titles put:title];
    [_actions put:[action copy]];
    return self;
}

- (void)create {
    _sheet = [UIActionSheet.alloc initWithTitle:_title delegate:self cancelButtonTitle:nil
                         destructiveButtonTitle:_destructiveTitle otherButtonTitles:nil, nil];

    for (NSObject *title in _titles) [_sheet addButtonWithTitle:title.description];

    [_sheet addButtonWithTitle:_cancel ? _cancel : @"Cancel"];
    _sheet.cancelButtonIndex = _titles.count;

    _visible = YES;
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    _sheet = nil;
    _visible = NO;
    if (_onDestructive && buttonIndex == actionSheet.destructiveButtonIndex) run(_onDestructive);
    if (buttonIndex == actionSheet.cancelButtonIndex) return;
    else if ([_actions at:buttonIndex]) run([_actions at:buttonIndex]);
    else if (_singleAction) _singleAction(buttonIndex);
}

- (instancetype)showFromBarItem:(UIBarButtonItem *)item {
    [self create];
    if ([UIDevice iPad]) [_sheet showFromBarButtonItem:item animated:YES];
    else [_sheet showInView:UIApplication.sharedApplication.delegate.window];
    return self;
}

- (instancetype)showFromRect:(CGRect)rect inView:(UIView *)view {
    [self create];
    if ([UIDevice iPad]) [_sheet showFromRect:rect inView:view animated:YES];
    else [_sheet showInView:UIApplication.sharedApplication.delegate.window];
    return self;
}

- (void)hide {
    [_sheet dismissWithClickedButtonIndex:_titles.count animated:YES];
}

- (CSActionSheet *)showInView:(UIView *)view {
    [self create];
    [_sheet showInView:view];
    return self;
}

- (CSActionSheet *)clear {
    _titles = NSMutableArray.new;
    _actions = NSMutableArray.new;
    return self;
}

@end
