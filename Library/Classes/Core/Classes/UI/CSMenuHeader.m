//
// Created by Rene Dohan on 14/03/18.
//

#import "CSMenuHeader.h"
#import "NSObject+CSExtension.h"
#import "NSMutableArray+CSExtension.h"
#import "CSMenuItem.h"
#import "CSMainController.h"

@implementation CSMenuHeader {
    CSMainController *_controller;
}

- (instancetype)construct:(CSMainController *)controller :(int)index :(NSString *)title {
    _controller = controller;
    _index = index;
    _title = title;
    _items = NSMutableArray.new;
    return self;
}

- (CSMenuItem *)item:(NSString *)name {
    var item = [_items add:[CSMenuItem.new construct:_controller :name]];
    item.index = (NSUInteger) (_items.size - 1);
    return item;
}

- (CSMenuItem *)item:(NSString *)name :(NSString *)subTitle :(void (^)(CSMenuItem *))_onClick {
    var item = [self item:name];
    item.subTitle = subTitle;
    [item onClick:_onClick];
    return item;
}

- (CSMenuItem *)item:(NSString *)title :(void (^)(CSMenuItem *))onClick {
    var item = [self item:title];
    item.action = onClick;
    return item;
}

- (instancetype)clear {
    _items.removeAllObjects;
    return self;
}

- (CSMenuItem *)item:(NSString *)title type:(UIBarButtonSystemItem)type {
    CSMenuItem *item = [self item:title];
    item.systemItem = type;
    return item;
}

- (CSMenuItem *)item:(NSString *)title image:(UIImage *)image {
    CSMenuItem *item = [self item:title];
    item.image = image;
    return item;
}

- (CSMenuItem *)item:(NSString *)title type:(UIBarButtonSystemItem)type :(void (^)(CSMenuItem *))onClick {
    CSMenuItem *item = [self item:title :onClick];
    item.systemItem = type;
    return item;
}

- (BOOL)visible {
    for (CSMenuItem *item in _items) if (item.visible) return YES;
    return NO;
}

- (CSMenuItem *)itemView:(UIView *)view {
    CSMenuItem *item = [self item:@""];
    item.view = view;
    return item;
}

- (BOOL)isDisplayedAsItem {
    return [NSString empty:_title] && _items.count == 1;
}

@end