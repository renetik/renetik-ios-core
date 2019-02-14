//
//  Created by Rene Dohan on 12/29/12.
//

@import Foundation;

#import "CSResponse.h"

@interface CSMultiResponse : CSResponse

- (instancetype)construct:(CSResponse *)request;

- (CSResponse *)add:(CSResponse *)response;

- (CSResponse *)addLast:(CSResponse *)request;

@end