//
//  Created by Rene Dohan on 5/11/12.
//


#import <Foundation/Foundation.h>


@interface CSWork : NSObject

- (instancetype)construct:(double)delay :(void (^)())workToInvoke;

@property(nonatomic) int count;

@property(nonatomic) double delay;

- (instancetype)start;

- (instancetype)startAndRun;

- (CSWork *)stop;

- (instancetype)run;

@end