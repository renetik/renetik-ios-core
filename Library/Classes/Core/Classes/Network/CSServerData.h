//
// Created by Rene on 2018-11-21.
//

#import <Foundation/Foundation.h>

@protocol CSServerData <NSObject>

@property(readonly) BOOL isEmpty;
@property(readonly) BOOL success;
@property(readonly) NSString *message;

- (instancetype)loadJson:(NSString *)jsonString;

- (void)message:(NSString *)value;

- (void)clear;

@end