//
//  Created by Rene Dohan on 12/30/12.
//


@import Foundation;

@class CSEventRegistration;

NS_ASSUME_NONNULL_BEGIN

typedef void (^CSEventBlock)(id, CSEventRegistration *);

@interface CSArgEvent<Argument> : NSObject

- (CSEventRegistration *)add:(CSEventBlock)block;

- (void)remove:(CSEventBlock)block;

- (void)fire:(Argument)argument;

- (void)fire;

@end

NS_ASSUME_NONNULL_END