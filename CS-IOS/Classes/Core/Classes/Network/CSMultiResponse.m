//
//  Created by Rene Dohan on 12/29/12.
//


#import "CSMultiResponse.h"
#import "NSObject+CSExtension.h"


@implementation CSMultiResponse {
    CSResponse *_request;
}

- (instancetype)construct:(CSResponse *)request {
    super.construct;
    [self add:request];
    return self;
}

- (CSResponse *)add:(CSResponse *)request {
    _request = request;
    [self failIfFail:request];
    return request;
}

- (void)cancel {
    [super cancel];
    [_request cancel];
}

- (CSResponse *)addLast:(CSResponse *)request {
    return [[self add:request] onSuccess:^(id id) {
        [self success:id];
    }];
}

@end