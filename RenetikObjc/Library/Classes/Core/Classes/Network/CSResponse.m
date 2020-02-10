//
//  Created by Rene Dohan on 11/2/12.
//

#import "CSResponse.h"
#import "CSArgEvent.h"
#import "NSString+CSExtension.h"
#import "CSLang.h"
#import "CSCocoaLumberjack.h"

@implementation CSResponse {
    CSArgEvent<CSResponse *> *_onFailedEvent;
    CSArgEvent<NSNumber *> *_onProgressEvent;
    CSArgEvent<id> *_onSuccessEvent;
    CSArgEvent<id> *_onCancelEvent;
    CSArgEvent<id> *_onDoneEvent;
    NSString *_id;
    BOOL _isSuccess;
    BOOL _isFailed;
    BOOL _isCanceled;
    BOOL _isDone;
    CSResponse *_failedResponse;
}

- (id)init {
    if (self = super.init) {
        _onProgressEvent = CSArgEvent.new;
        _onFailedEvent = CSArgEvent.new;
        _onSuccessEvent = CSArgEvent.new;
        _onCancelEvent = CSArgEvent.new;
        _onDoneEvent = CSArgEvent.new;
        _requestCancelledMessage = @"Request cancelled.";
    }
    return self;
}

- (id)initWith:(NSString *)url :(NSString *)service :(id)data :(NSDictionary *)params {
    if (self = [self init]) {
        _url = url;
        _service = service;
        _data = data;
        _params = params;
        infof(@"%@ %@ %@", url, service, params);
    }
    return self;
}

- (id)initWith:(id)data {
    if (self = self.init) _data = data;
    return self;
}

- (NSString *)description {
    let format = @"url:%@ service:%@ message:%@ params:%@ post:%@ content:%@";
    return stringf(format, _url, _service, _message, _params, _post, _content);
}

- (void)success:(id)data {
    if (_isDone) return;
    _data = data;
    _isSuccess = YES;
    [_onSuccessEvent fire:self.data];
    self.done;
}

- (void)failed:(CSResponse *)response {
    if (_isDone) return;
    _isFailed = YES;
    _failedResponse = response;
    NSLog(@"Response failed %@", response.message);
    [_onFailedEvent fire:response];
    self.done;
}

- (instancetype)failedWithMessage:(NSString *)message {
    if (_isDone) return self;
    self.message = message;
    [self failed:self];
    return self;
}

- (void)cancel {
    self.message = self.requestCancelledMessage;
    _isCanceled = YES;
    [_onCancelEvent fire:self];
    self.done;
}

- (void)done {
    _isDone = YES;
    [_onDoneEvent fire:self.data];
}

- (CSResponse *)failIfFail:(CSResponse *)response {
    return [response onFailed:^(CSResponse *_response) {
        [self failed:_response];
    }];
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

- (instancetype)onSuccess:(void (^)(id))onSuccess {
    [_onSuccessEvent add:^(id argument, CSEventRegistered *registration) {
        onSuccess(argument);
    }];
    return self;
}

- (instancetype)onProgress:(void (^)(NSNumber *))onProgress {
    [_onProgressEvent add:^(NSNumber *progress, CSEventRegistered *registration) {
        onProgress(progress);
    }];
    return self;
}

- (instancetype)onCancel:(void (^)(id))onCancel {
    [_onCancelEvent add:^(id argument, CSEventRegistered *registration) {
        onCancel(argument);
    }];
    return self;
}

- (instancetype)onDone:(void (^)(id))onDone {
    [_onDoneEvent add:^(id argument, CSEventRegistered *registration) {
        onDone(argument);
    }];
    return self;
}

- (instancetype)onFailed:(void (^)(CSResponse *))onFailed {
    [_onFailedEvent add:^(CSResponse *argument, CSEventRegistered *registration) {
        onFailed(argument);
    }];
    return self;
}

- (instancetype)setProgress:(double)completed {
    [_onProgressEvent fire:@(completed)];
    return self;
}

- (instancetype)force:(BOOL)reload {
    _forceReload = reload;
    return self;
}

- (id)fromCacheIfPossible:(BOOL)force {
    _fromCacheIfPossible = force;
    return self;
}

- (NSString *)message {
    if (!_message && _failedResponse) return _failedResponse.message;
    return _message;
}

@end
