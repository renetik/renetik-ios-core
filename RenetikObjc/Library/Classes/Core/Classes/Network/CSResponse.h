//
//  Created by Rene Dohan on 11/2/12.
//

@import Foundation;

@protocol CSServerData;

static NSString *const INVALID_RESPONSE_FROM_SERVER = @"Invalid response from server";
NS_ASSUME_NONNULL_BEGIN

@interface CSResponse<DataType> : NSObject

@property (copy, nonatomic) NSString *url;
@property (nonatomic) DataType data;
@property (copy, nonatomic) NSString *_Nullable content;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *requestCancelledMessage;
@property (nonatomic) NSInteger errorCode;
@property (nonatomic) NSDictionary *params;
@property (nonatomic) NSDictionary *post;
@property (nonatomic, readonly) BOOL canceled;
@property (nonatomic, readonly) BOOL failed;
@property (nonatomic) BOOL done;
@property (nonatomic) BOOL success;
@property (nonatomic) BOOL forceReload;
@property (nonatomic) BOOL fromCacheIfPossible;
@property (nonatomic, weak) UIViewController *controller;

- (id)initWith :(id)data;

- (id)initWith :(NSString *)url :(DataType)data :(NSDictionary *)params;

- (void)success :(nullable DataType)data;

- (void)failed :(CSResponse *)response;

- (void)cancel;


- (CSResponse *)failIfFail :(CSResponse *)request;

- (CSResponse *)connect :(CSResponse *)response;

- (CSResponse *)successIfSuccess :(CSResponse *)response;

- (instancetype)failedWithMessage :(NSString *)string;

- (instancetype)onSuccess :(void (^)(DataType))onSuccess;

- (instancetype)onProgress :(void (^)(NSNumber *))onProgress;

- (instancetype)onDone :(void (^)(DataType))block;

- (instancetype)onFailed :(void (^)(CSResponse *))block;

- (instancetype)setProgress :(double)completed;

- (void)reset;

- (instancetype)fromCacheIfPossible :(BOOL)force;

- (instancetype)force :(BOOL)reload;

- (instancetype)setId :(id)id;

- (NSString *)id;

@end

NS_ASSUME_NONNULL_END
