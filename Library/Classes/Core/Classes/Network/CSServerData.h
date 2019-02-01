//
// Created by Rene on 2018-11-21.
//

@import Foundation;

@protocol CSServerData <NSObject>

@property (readonly) BOOL isEmpty;
@property (readonly) BOOL success;
@property (readonly) NSString *message;

- (void)loadContent :(NSString *)content;

- (void)message :(NSString *)value;

- (void)clear;

@end
