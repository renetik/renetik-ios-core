#import "CSLang.h"

@implementation CSLang

void run(void (^block)(void)) {
    if (block) block();
}

id nilToNull(id object) {
    if (object == nil) return NSNull.null;
    return object;
}

id nullToNil(id object) {
    if (object == NSNull.null) return nil;
    return object;
}

BOOL is(id object) {
    return object != nil && object != NSNull.null;
}

id stringify(id object) {
    if (object == nil) return @"";
    return stringf(@"%@", object);
}

void runWith(void (^block)(id), id value) {
    if (block) block(value);
}

void doLater(NSTimeInterval delay, void (^block)(void)) {
    if (!block) return;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (delay * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
}

void doLaterWith(NSTimeInterval delay, id value, void (^block)(id)) {
    if (!block) return;
    doLater(delay, ^{
        runWith(block, value);
    });
}

void invokeWith(void (^block)(id), id value) {
    if (!block) return;
    dispatch_async(dispatch_get_main_queue(), ^{runWith(block, value);});
}

BOOL isDebug() {
    return DEBUGMODE;
}

UIEdgeInsets UIEdgeInsetMake(CGFloat inset) {
    return (UIEdgeInsets) {inset, inset, inset, inset};
}

BOOL bitmaskContains(NSUInteger mask, NSUInteger contains) {
    return (mask & contains) != 0;
}

@end
