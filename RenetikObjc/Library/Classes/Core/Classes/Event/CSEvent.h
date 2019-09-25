//
//  Created by Rene Dohan on 12/30/12.
//


@import Foundation;

@class CSEventRegistration;

NS_ASSUME_NONNULL_BEGIN
typedef void (^CSEventBlock)(CSEventRegistration *);

@interface CSEvent : NSObject

- (CSEventRegistration *)add:(CSEventBlock)block;

- (void)remove:(CSEventBlock)block;

- (void)run;

@end
NS_ASSUME_NONNULL_END