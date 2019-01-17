//
//  Created by Rene Dohan on 5/11/12.
//

#import "CSWork.h"
#import "CSLang.h"
#import "NSObject+CSExtension.h"

#import "CSDoLaterProcess.h"

@implementation CSWork {
    BOOL _stop;

    void (^_workToInvoke)();

    CSDoLaterProcess *_doLater;
}

- (instancetype)construct:(double)delay :(void (^)())workToInvoke {
    _delay = delay;
    _workToInvoke = workToInvoke;
    _stop = YES;
    return self;
}

- (instancetype)start {
    if (_stop) {
        _stop = NO;
        [self process];
    }
    return self;
}

- (instancetype)startAndRun {
    [self run];
    [self start];
    return self;
}

- (instancetype)stop {
    if (_stop) return self;
    _stop = YES;
    if (_doLater) [_doLater stop];
    return self;
}

- (void)process {
    _doLater = [self doLater:_delay :^{
        if (!_stop) {
            _count++;
            run(_workToInvoke);
            [self process];
        }
    }];
}

- (instancetype)run {
    run(_workToInvoke);
    return self;
}

@end
