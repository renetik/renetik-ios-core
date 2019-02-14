//
//  Created by Rene Dohan on 12/30/12.
//


@import Foundation;

@class CSEventRegistration;

@interface CSEvent : NSObject {
    NSMutableArray<void (^)(void)> *_blockArray;
}

- (CSEventRegistration *)add:(void (^)(void))block;

- (void)remove:(void (^)(void))block;

- (void)run;

@end