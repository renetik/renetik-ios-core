//
//  Created by Rene Dohan on 1/2/13.
//


#import "CSDoLaterProcess.h"

@implementation CSDoLaterProcess {
    id _method;
    BOOL _stop;
}

- (void)methodToPerform:(void (^)())methodToInvoke {
    if (_stop)return;
    if (NSThread.isMainThread) methodToInvoke();
    else [self performSelectorOnMainThread:@selector(methodToPerform:) withObject:methodToInvoke waitUntilDone:NO];
}

- (CSDoLaterProcess *)from:(void (^)())method :(NSTimeInterval)delay {
    [self performSelector:@selector(methodToPerform:) withObject:method afterDelay:delay];
    _method = method;
    return self;
}

- (void)stop {
    if (_stop)return;
    _stop = YES;
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(methodToPerform:) object:_method];
}

@end