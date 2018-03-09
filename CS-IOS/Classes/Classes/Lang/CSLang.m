#import <MBProgressHUD/MBProgressHUD.h>
#import "CSLang.h"
#import "NSString+CSExtension.h"
#import "MBProgressHUD+CSExtension.h"

@implementation CSLang

void run(void (^block)(void)) {
    if (block) block();
}

id nilToNULL(id object) {
    if (object == nil) return [NSNull null];
    return object;
}

id stringify(id object) {
    if (object == nil) return @"";
    return stringf(@"%@", object);
}

void runWith(void (^block)(id), id value) {
    if (block)block(value);
}

void doLater(void (^block)(void), NSTimeInterval delay) {
    if (!block)return;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (delay * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
}

void doLaterWith(void (^block)(id), id value, NSTimeInterval delay) {
    if (!block)return;
    doLater(^{
        runWith(block, value);
    }, delay);
}

void invoke(void (^block)(void)) {
    if (!block)return;
    dispatch_after(0.0f, dispatch_get_main_queue(), block);
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

@end
