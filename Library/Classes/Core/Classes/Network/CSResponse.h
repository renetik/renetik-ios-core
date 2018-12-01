//
//  Created by Rene Dohan on 11/2/12.
//
#import "UIKit/UIKit.h"

@protocol CSServerDataProtocol;

static NSString *const INVALID_RESPONSE_FROM_SERVER = @"Invalid response from server";
NS_ASSUME_NONNULL_BEGIN

@interface CSResponse<__covariant DataType> : NSObject

@property(copy, nonatomic) NSString *url;
@property(copy, nonatomic) NSString *content;
@property(nonatomic, copy) NSString *message;
@property(nonatomic) NSInteger errorCode;
@property(nonatomic) NSDictionary *params;
@property(nonatomic) NSDictionary *post;
@property(nonatomic, readonly) BOOL canceled;
@property(nonatomic, readonly) BOOL failed;
@property(nonatomic) BOOL done;
@property(nonatomic) BOOL success;
@property(nonatomic) BOOL forceReload;
@property(nonatomic) BOOL fromCacheIfPossible;
@property(nonatomic, weak) UIViewController *controller;

- (void)success:(DataType)data;

- (DataType)data;

- (void)setData:(DataType)data;

- (void)failed:(CSResponse *)response;

- (void)cancel;

- (NSString *)requestCancelledMessage;

- (CSResponse *)failIfFail:(CSResponse *)request;

- (CSResponse *)connect:(CSResponse *)response;

- (CSResponse *)successIfSuccess:(CSResponse *)response;

- (instancetype)failedWithMessage:(NSString *)string;

- (instancetype)onSuccess:(void (^)(DataType))onSuccess;

- (instancetype)onProgress:(void (^)(NSNumber *))onProgress;

- (instancetype)onDone:(void (^)(DataType))block;

- (instancetype)onFailed:(void (^)(CSResponse *))block;

- (instancetype)setProgress:(double)completed;

- (void)reset;

- (instancetype)fromCacheIfPossible:(BOOL)force;

- (instancetype)reload:(BOOL)reload;

- (instancetype)setId:(id)id;

- (NSString *)id;

@end

NS_ASSUME_NONNULL_END
