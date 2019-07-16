//
//  Created by Rene Dohan on 1/12/13.
//


#import "CSResponse.h"
#import "CSConcurrentResponse.h"
#import "NSObject+CSExtension.h"
#import "NSArray+CSExtension.h"
#import "NSMutableArray+CSExtension.h"
#import "CSLang.h"


@implementation CSConcurrentResponse {
    NSMutableArray *_failedResponses;
    NSMutableArray *_responses;
}

- (instancetype)init {
    if (self = super.init) {
        _failedResponses = NSMutableArray.new;
        _responses = NSMutableArray.new;
        self.data = NSMutableArray.new;
    }
    return self;
}

- (instancetype)addAll:(NSArray *)responses {
    for (CSResponse *response in responses) [self add:response];
    return self;
}

- (CSResponse *)add:(CSResponse *)response {
    [self.data put:response.data];
    __weak CSResponse *wResponse = [_responses put:response];
    return [[response onFailed:^(CSResponse *failedResponse) {[self onResponseFailed:wResponse];}]
            onSuccess:^(id data) {[self onResponseSuccess:wResponse];}];
}

- (void)onResponseSuccess:(CSResponse *)response {
    if ([_responses remove:response].empty) [self onResponsesDone];
}

- (void)onResponseFailed:(CSResponse *)failedResponse {
    if ([_responses remove:[_failedResponses put:failedResponse]].empty) [self onResponsesDone];
}

- (void)cancel {
    for (CSResponse *response in _responses) [response cancel];
    super.cancel;
}

- (void)onAddDone {
    invoke(^{if (_responses.empty)[self onResponsesDone];});
}

- (void)onResponsesDone {
    if (_failedResponses.hasItems) [self failed:_failedResponses.first];
    else [self success:self.data];
}

@end
