//
//  Created by Rene Dohan on 11/2/12.
//

#import "CSArgEvent.h"
#import "CSResponse.h"
#import "NSString+CSExtension.h"
#import "CSLang.h"
#import "CSCocoaLumberjack.h"

@implementation CSResponse {
    CSArgEvent<CSResponse*>*_onFailedEvent;
    CSArgEvent<NSNumber*>*_onProgressEvent;
    CSArgEvent<id>*_onSuccessEvent;
    CSArgEvent<id>*_onCancelEvent;
    CSArgEvent<id>*_onDoneEvent;
    NSString*_id;
}

- (id)init {
    if(self = super.init) {
        _onProgressEvent = CSArgEvent.new;
        _onFailedEvent = CSArgEvent.new;
        _onSuccessEvent = CSArgEvent.new;
        _onCancelEvent = CSArgEvent.new;
        _onDoneEvent = CSArgEvent.new;
        _requestCancelledMessage = @"Request cancelled.";
    }
    return self;
}

- (id)initWith :(NSString*)url :(NSString*)service:(id)data :(NSDictionary*)params {
    if(self = [self init]) {
        _url = url;
        _service = service;
        _data = data;
        _params = params;
        infof(@"%@ %@ %@", url, service, params);
    }
    return self;
}

- (id)initWith :(id)data {
    if(self = self.init) _data = data;
    return self;
}

- (NSString*)description {
	let format = @"url:%@ service:%@ message:%@ params:%@ post:%@ content:%@";
	return stringf(format, _url, _service, _message, _params, _post, _content);
}

- (void)success :(id)data {
    if(_done) return;
    _data = data;
	_success = YES;
	[_onSuccessEvent run:self.data];
    self.done;
}

- (void)failed :(CSResponse*)response {
    if(_done) return;
    _failed = YES;
    NSLog(@"Response failed %@", response.message);
    [_onFailedEvent run:response];
    self.done;
}

- (instancetype)failedWithMessage :(NSString*)message {
	if(_done) return self;
	self.message = message;
	[self failed:self];
	return self;
}

- (void)cancel {
	self.message = self.requestCancelledMessage;
	_canceled = YES;
    [_onCancelEvent run:self];
	self.done;
}

- (void)done {
	_done = YES;
	[_onDoneEvent run:self.data];
}

- (CSResponse*)failIfFail :(CSResponse*)response {
    return [response onFailed:^(CSResponse*_response) {
        [self failed:_response];
    }];
}

- (CSResponse*)successIfSuccess :(CSResponse*)response {
    return [response onSuccess:^(id value) { [self success:value]; }];
}

- (CSResponse*)connect :(CSResponse*)response {
    [self failIfFail:response];
    [self successIfSuccess:response];
    return response;
}

- (instancetype)onSuccess :(void (^)(id))onSuccess {
    [_onSuccessEvent add:onSuccess];
    return self;
}

- (instancetype)onProgress :(void (^)(NSNumber*))onProgress {
    [_onProgressEvent add:onProgress];
    return self;
}

- (instancetype)onCancel :(void (^)(id))block {
    [_onCancelEvent add:block];
    return self;
}

- (instancetype)onDone :(void (^)(id))block {
    [_onDoneEvent add:block];
    return self;
}

- (instancetype)onFailed :(void (^)(CSResponse*))block {
    [_onFailedEvent add:block];
    return self;
}

- (instancetype)setProgress :(double)completed {
    [_onProgressEvent run:@(completed)];
    return self;
}

- (instancetype)force :(BOOL)reload {
    _forceReload = reload;
    return self;
}

//- (instancetype)setId :(NSString*)id {
//    _id = id;
//    return self;
//}
//
//- (NSString*)id {
//    return _id;
//}

- (id)fromCacheIfPossible :(BOOL)force {
    _fromCacheIfPossible = force;
    return self;
}

@end
