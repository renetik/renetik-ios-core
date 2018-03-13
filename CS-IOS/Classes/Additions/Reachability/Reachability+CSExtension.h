//
//  Created by Rene Dohan on 7/17/12.
//


#import <Foundation/Foundation.h>
#import <Reachability/Reachability.h>

@interface Reachability (CSExtension)

+ (BOOL)isReachable:(NSString *)URL;

- (void)setOnReachable:(NetworkReachable)onReachable;

- (void)setOnChange:(void (^)())onChange;

- (void)setOnUpdate:(void (^)(Reachability *))onChange;
@end