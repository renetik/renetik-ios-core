////
////  Created by Rene Dohan on 7/17/12.
////
//
//#import "Reachability+CSExtension.h"
//#import "CSLang.h"
//
//@implementation Reachability (CSExtension)
//
//+ (BOOL)isReachable:(NSString *)URL {
//    return [Reachability reachabilityWithHostname:URL].currentReachabilityStatus != NotReachable;
//}
//
//- (void)setOnReachable:(NetworkReachable)onReachable {
//    if (onReachable)
//        self.reachableBlock = ^(Reachability *reachability) {
//            invokeWith(onReachable, reachability);
//        };
//    else self.reachableBlock = nil;
//}
//
//
//- (void)setOnChange:(void (^)())onChange {
//    self.reachableBlock = ^(Reachability *_reachability) {
//        invoke(onChange);
//    };
//    self.unreachableBlock = ^(Reachability *_reachability) {
//        invoke(onChange);
//    };
//    [self startNotifier];
//}
//
//- (void)setOnUpdate:(void (^)(Reachability *))onChange {
//    self.reachableBlock = ^(Reachability *_reachability) {
//        invokeWith(onChange, _reachability);
//    };
//    self.unreachableBlock = ^(Reachability *_reachability) {
//        invokeWith(onChange, _reachability);
//    };
//    [self startNotifier];
//}
//
//@end
