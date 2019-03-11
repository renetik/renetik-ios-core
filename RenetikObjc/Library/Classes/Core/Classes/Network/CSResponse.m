//
//  Created by Rene Dohan on 11/2/12.
//

#import "CSArgEvent.h"
#import "CSResponse.h"
#import "NSString+CSExtension.h"
#import "CSCocoaLumberjack.h"

@implementation CSResponse {
    CSArgEvent<CSResponse *> *_onFailedEvent;
    CSArgEvent<NSNumber *> *_onProgressEvent;
    CSArgEvent<id> *_onSuccessEvent;
    CSArgEvent<id> *_onDoneEvent;
    NSString *_id;
}

- (id)init {
    if (self = [super init]) {
        _onProgressEvent = CSArgEvent.new;
        _onFailedEvent = CSArgEvent.new;
        _onSuccessEvent = CSArgEvent.new;
        _onDoneEvent = CSArgEvent.new;
    }
    return self;
}

- (id)initWith :(NSString *)url :(id)data :(NSDictionary *)params {
    if (self = [self init]) {
        _url = url;
        _data = data;
        _params = params;
        infof(@"%@ %@", url, params);
    }
    return self;
}

- (id)initWith :(id)data {
    if (self = [self init]) {
        _data = data;
    }
    return self;
}

- (void)success :(id)data {
    if (_canceled) return;
    _data = data;
    [self onSuccessEvent];
    [self onDoneEvent];
}

- (void)onSuccessEvent {
    _success = YES;
    [_onSuccessEvent run :self.data];
}

- (void)onDoneEvent {
    _done = YES;
    [_onDoneEvent run :self.data];
}

- (void)failed :(CSResponse *)response {
    if (_canceled) return;
    _failed = YES;
    NSLog(@"Response failed %@", response.message);
    [_onFailedEvent run :response];
    [self onDoneEvent];
}

- (void)cancel {
    [self failedWithMessage :self.requestCancelledMessage];
    _canceled = YES;
}

- (NSString *)requestCancelledMessage {
    return @"Request cancelled.";
}

- (CSResponse *)failIfFail :(CSResponse *)response {
    return [response onFailed :^(CSResponse *_response) {
        [self failed :_response];
    }];
}

- (NSString *)description {
    return [@"Response: " add :@"URL: " :self.url :@"\nMessage:" :self.message :@"\nParams: " :self.params :@"\nPost: "
                              :self.post :@"\nServer response content: " :self.content];
}

- (CSResponse *)successIfSuccess :(CSResponse *)response {
    return [response onSuccess :^(id value) {
        [self success :value];
    }];
}

- (CSResponse *)connect :(CSResponse *)response {
    [self failIfFail :response];
    [self successIfSuccess :response];
    return response;
}

- (instancetype)failedWithMessage :(NSString *)message {
    if (_canceled) return self;
    self.message = message;
    [self failed :self];
    return self;
}

- (instancetype)onSuccess :(void (^)(id))onSuccess {
    [_onSuccessEvent add :onSuccess];
    return self;
}

- (instancetype)onProgress :(void (^)(NSNumber *))onProgress {
    [_onProgressEvent add :onProgress];
    return self;
}

- (instancetype)onDone :(void (^)(id))block {
    [_onDoneEvent add :block];
    return self;
}

- (instancetype)onFailed :(void (^)(CSResponse *))block {
    [_onFailedEvent add :block];
    return self;
}

- (instancetype)setProgress :(double)completed {
    [_onProgressEvent run :@(completed)];
    return self;
}

- (instancetype)force :(BOOL)reload {
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

- (instancetype)setId :(NSString *)id {
    _id = id;
    return self;
}

- (NSString *)id {
    return _id;
}

- (id)fromCacheIfPossible :(BOOL)force {
    _fromCacheIfPossible = force;
    return self;
}

@end
