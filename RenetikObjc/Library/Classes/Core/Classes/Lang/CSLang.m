#import <MBProgressHUD/MBProgressHUD.h>
#import "CSLang.h"
#import "NSString+CSExtension.h"
#import "MBProgressHUD+CSExtension.h"
#import "NSMutableArray+CSExtension.h"
#import "NSMutableDictionary+CSExtension.h"

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

NSMutableArray *muteArray(NSArray *array) {
    return [NSMutableArray.new construct:array];
}

NSMutableDictionary *muteDict(NSDictionary *dictionary) {
    return [NSMutableDictionary.new construct:dictionary];
}

void runWith(void (^block)(id), id value) {
    if (block)block(value);
}

void doLater(NSTimeInterval delay, void (^block)(void)) {
    if (!block)return;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (delay * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
}

void doLaterWith(void (^block)(id), id value, NSTimeInterval delay) {
    if (!block)return;
    doLater(delay, ^{
        runWith(block, value);
    });
}

void invoke(void (^block)(void)) {
    if (!block)return;
    dispatch_async(dispatch_get_main_queue(), block);
}

void invokeWith(void (^block)(id), id value) {
    if (!block)return;
    invoke(^{
        runWith(block, value);
    });
}

void showMessage(NSString *title) {
    [MBProgressHUD showMessage:title];
}

BOOL isDebug() {
    return DEBUGMODE;
}

NSString *format(NSString *format, NSObject *argument) {
    return [NSString format:format :argument :nil];
}

NSString *format2(NSString *format, NSObject *argument, NSObject *argument2) {
    return [NSString format:format :argument :argument2];
}

NSString *format3(NSString *format, NSObject *argument, NSObject *argument2, NSObject *argument3) {
    return [NSString format:format :argument :argument2 :argument3];
}

NSString *format4(NSString *format, NSObject *argument, NSObject *argument2, NSObject *argument3, NSObject *argument4) {
    return [NSString format:format :argument :argument2 :argument3 :argument4];
}

UIEdgeInsets UIEdgeInsetMake(CGFloat inset) {
    return (UIEdgeInsets) {inset, inset, inset, inset};
}


@end
