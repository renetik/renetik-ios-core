//
//  Created by Rene Dohan on 12/30/12.
//


@import Foundation;

@class CSEventRegistered;

NS_ASSUME_NONNULL_BEGIN

typedef void (^CSEventBlock)(id, CSEventRegistered *);

@interface CSArgEvent<Argument> : NSObject

- (CSEventRegistered *)add:(CSEventBlock)block;

- (void)remove:(CSEventBlock)block;

- (void)fire:(Argument)argument;

- (void)fire;

@end

NS_ASSUME_NONNULL_END