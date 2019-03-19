//
//  Created by Rene Dohan on 12/30/12.
//


#import "CSEvent.h"
#import "CSEventRegistration.h"
#import "CSLang.h"
#import "NSMutableArray+CSExtension.h"


@implementation CSEvent

- (id)init {
    if (self = [super init])
        _blockArray = [NSMutableArray new];
    return self;
}

- (void)run {
    for (void (^block)(void) in _blockArray) run(block);
}

- (CSEventRegistration *)add:(void (^)(void))block {
    void (^blockCopy)() = [block copy];
    [_blockArray put:blockCopy];
    return [CSEventRegistration.new construct:self :blockCopy];
}

- (void)remove:(void (^)(void))block {
    [_blockArray removeObject:block];
}

@end
