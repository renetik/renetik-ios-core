//
//  Created by Rene Dohan on 7/17/12.
//

@import Foundation;
@import Reachability;

@interface Reachability (CSExtension)

+ (BOOL)isReachable:(NSString *)URL;

- (void)setOnReachable:(NetworkReachable)onReachable;

- (void)setOnChange:(void (^)(void))onChange;

- (void)setOnUpdate:(void (^)(Reachability *))onChange;
@end