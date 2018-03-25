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
    super.construct;
    _controller = controller;
    _index = index;
    _title = title;
    _items = NSMutableArray.new;
    return self;
}

- (CSMenuItem *)item:(NSString *)name {
    return [_items add:[CSMenuItem.new construct:_controller :_title]];
}

- (instancetype)clear {
    _items.removeAllObjects;
    return self;
}

@end