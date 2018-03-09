//
//  Created by Rene Dohan on 11/2/12.
//

#import "CSArgEvent.h"
#import "CSResponse.h"
#import "CSCocoaLumberjack.h"
#import "NSString+CSExtension.h"

@implementation CSResponse {
    CSArgEvent<CSResponse *> *_onFailedEvent;
    CSArgEvent<NSNumber *> *_onProgressEvent;
    CSArgEvent<id> *_onSuccessEvent;
    CSArgEvent<id> *_onDoneEvent;
    NSString *_id;
    id _data;
}

- (id)init {
    if (self = [super init]) {
        _onFailedEvent = [CSArgEvent new];
        _onSuccessEvent = [CSArgEvent new];
        _onDoneEvent = [CSArgEvent new];
    }
    return self;
}

- (void)success:(id)data {
    if (_canceled)return;
    _data = data;
    [self onSuccessEvent];
    [self onDoneEvent];
}

- (id)data {
    return _data;
}

- (void)setData:(id)data {
    _data = data;
}

- (void)onSuccessEvent {
    _success = YES;
    [_onSuccessEvent run:self.data];
}

- (void)onDoneEvent {
    _done = YES;
    [_onDoneEvent run:self.data];
}

- (void)failed:(CSResponse *)response {
    if (_canceled)return;
    infof(@"Response failed %@", response.message);
    [self onFailedEvent:response];
    [self onDoneEvent];
}

- (void)onFailedEvent:(CSResponse *)response {
    _failed = YES;
    [_onFailedEvent run:response];
}

- (void)cancel {
    _canceled = YES;
    [self onDoneEvent];
}

- (CSResponse *)failIfFail:(CSResponse *)response {
    return [response onFailed:^(CSResponse *_response) {
        [self failed:_response];
    }];
}

- (NSString *)description {
    return [@"Response: " add:@"URL: " :self.url :@"\nMessage:" :self.message :@"\nParams: " :self.params :@"\nPost: "
            :self.post :@"\nServer response content: " :self.content];
}

- (CSResponse *)successIfSuccess:(CSResponse *)response {
    return [response onSuccess:^(id value) {
        [self success:value];
    }];
}

- (CSResponse *)connect:(CSResponse *)response {
    [self failIfFail:response];
    [self successIfSuccess:response];
    return response;
}

- (instancetype)failedWithMessage:(NSString *)message {
    self.message = message;
    [self failed:self];
    return self;
}

- (instancetype)onSuccess:(void (^)(id))onSuccess {
    [_onSuccessEvent add:onSuccess];
    return self;
}

- (instancetype)onProgress:(void (^)(NSNumber *))onProgress {
    [_onProgressEvent add:onProgress];
    return self;
}

- (instancetype)onDone:(void (^)(id))block {
    [_onDoneEvent add:block];
    return self;
}

- (instancetype)onFailed:(void (^)(CSResponse *))block {
    [_onFailedEvent add:block];
    return self;
}

- (instancetype)setProgress:(double)completed {
    [_onProgressEvent run:@(completed)];
    return self;
}

- (instancetype)reload:(BOOL)reload {
    _forceReload = reload;
    return self;
}

- (void)reset {
    _message = nil;
    _done = false;
    _success = false;
    _failed = false;
    _canceled = false;
}

- (instancetype)setId:(NSString *)id {
    _id = id;
    return self;
}

- (NSString *)id {
    return _id;
}

- (id)fromCacheIfPossible:(BOOL)force {
    _fromCacheIfPossible = force;
    return self;
}

@end