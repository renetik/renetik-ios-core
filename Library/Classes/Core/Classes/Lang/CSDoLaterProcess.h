//
//  Created by Rene Dohan on 1/2/13.
//


@import Foundation;

@interface CSDoLaterProcess : NSObject

- (CSDoLaterProcess *)from:(void (^)(void))method :(NSTimeInterval)delay;

- (void)stop;

@end