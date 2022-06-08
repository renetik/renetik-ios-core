//
//  Created by Rene Dohan on 5/11/12.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN
@interface CSWork : NSObject

- (instancetype)construct :(NSTimeInterval)delay :(void (^)(void))workToInvoke;

@property (nonatomic) int count;

@property (nonatomic) NSTimeInterval delay;

- (instancetype)start;

- (instancetype)startAndRun;

- (CSWork *)stop;

- (instancetype)run;

@end
NS_ASSUME_NONNULL_END
