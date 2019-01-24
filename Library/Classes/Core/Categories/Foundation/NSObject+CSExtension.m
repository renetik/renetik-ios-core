//
//  Created by Rene Dohan on 4/29/12.
//

#import "CSWork.h"
#import "CSDoLaterProcess.h"
#import "BlocksKit.h"

@implementation NSObject (CSExtension)

+ (instancetype)as:(id)obj {
    if ([obj isKindOfClass:self]) {return obj;}
    return nil;
}

- (id)as:(Protocol *)aProtocol {
    return [self.class conformsToProtocol:aProtocol] ? self : nil;
}

- (instancetype)setObject:(const void *)key :(id)value {
    [self bk_associateValue:value withKey:key];
    return self;
}

- (instancetype)setWeakObject:(const void *)key :(id)value {
    [self bk_weaklyAssociateValue:value withKey:key];
    return self;
}

- (id)getObject:(const void *)key {
    return [self bk_associatedValueForKey:key];
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
    return [CSDoLaterProcess.new from:method :0.1];
}

- (CSDoLaterProcess *)doLater:(double)seconds :(void (^)(void))method {
    return [CSDoLaterProcess.new from:method :seconds];
}

- (CSWork *)schedule:(double)seconds :(void (^)(void))method {
    return [CSWork.new construct:seconds :method];
}

- (BOOL)isNotKindOfClass:(Class)aClass {
    return ![self isKindOfClass:aClass];
}

- (BOOL)isKindOfOneOfClass:(NSArray<Class> *)classes {
    for (Class aClass in classes) if ([self isKindOfClass:aClass])return YES;
    return NO;
}

+ (NSString *)className {
    return [self.class description];
}

- (NSString *)className {
    return [self.class description];
}

@end
