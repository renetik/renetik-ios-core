//
//  Created by Rene Dohan on 4/29/12.
//

#import "CSWork.h"
#import "CSDoLaterProcess.h"


@implementation NSObject (CSExtension)

- (instancetype)construct {
    return self;
}

- (instancetype)addNotificationObserver:(SEL)sel name:(NSString *)name {
    [NSNotificationCenter.defaultCenter addObserver:self selector:sel name:name object:nil];
    return self;
}

- (instancetype)addNotificationObserver:(SEL)sel name:(NSString *)name for:(id)object {
    [NSNotificationCenter.defaultCenter addObserver:self selector:sel name:name object:object];
    return self;
}

- (instancetype)removeNotificationObserver {
    [NSNotificationCenter.defaultCenter removeObserver:self];
    return self;
}

- (CSDoLaterProcess *)doLater:(void (^)(void))method {
    return [[CSDoLaterProcess new] from:method :0.1];
}

- (CSDoLaterProcess *)doLater:(double)seconds :(void (^)(void))method {
    return [[CSDoLaterProcess new] from:method :seconds];
}

- (CSWork *)schedule:(double)seconds :(void (^)(void))method {
    return [CSWork.new construct:seconds :method];
}

- (BOOL)isKindOfOneOfClass:(NSArray *)classes {
    for (Class aClass in classes)
        if ([self isKindOfClass:aClass])return YES;
    return NO;
}

+ (NSString *)className {
    return [self.class description];
}

- (NSString *)className {
    return [self.class description];
}

@end
