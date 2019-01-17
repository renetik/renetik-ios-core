//
//  Created by Rene Dohan on 1/12/13.
//

#import <Foundation/Foundation.h>
#import "CSResponse.h"

@interface CSConcurrentResponse : CSResponse<NSMutableArray*>

- (instancetype)addAll:(NSArray *)responses;

- (CSResponse *)add:(CSResponse *)response;

- (void)onAddDone;

@end