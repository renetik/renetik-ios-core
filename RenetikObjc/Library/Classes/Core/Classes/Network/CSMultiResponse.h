//
//  Created by Rene Dohan on 12/29/12.
//

@import Foundation;

#import "CSResponse.h"
NS_ASSUME_NONNULL_BEGIN
@interface CSMultiResponse<Data> : CSResponse<Data>

- (instancetype)construct :(CSResponse *)request;

- (CSResponse *)add :(CSResponse *)response;

- (CSResponse<Data> *)addLast :(CSResponse<Data> *)request;

@end
NS_ASSUME_NONNULL_END
