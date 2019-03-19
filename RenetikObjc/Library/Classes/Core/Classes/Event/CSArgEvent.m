//
//  Created by Rene Dohan on 12/30/12.
//


#import "CSArgEvent.h"
#import "CSLang.h"
#import "NSArray+CSExtension.h"
#import "NSMutableArray+CSExtension.h"


@implementation CSArgEvent

- (id)init {
    if (self = [super init])
        _blockArray = [NSMutableArray new];
    return self;
}

- (void)run:(id)argument {
    for (void (^block)(id) in _blockArray) runWith(block, argument);
}

- (void)add:(void (^)(id))block {
    [_blockArray put:block];
}

- (void (^)(id))last {
    return _blockArray.last;
}
@end
