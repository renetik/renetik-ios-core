//
//  Created by Rene Dohan on 1/12/13.
//

@import Foundation;

#import "CSResponse.h"

NS_ASSUME_NONNULL_BEGIN
@interface CSConcurrentResponse : CSResponse<NSMutableArray *>

- (instancetype)addAll :(NSArray *)responses;

- (CSResponse *)add :(CSResponse *)response;

- (void)onAddDone;

@end
NS_ASSUME_NONNULL_END
