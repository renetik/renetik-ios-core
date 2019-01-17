//
//  Created by Rene Dohan on 4/29/12.
//


#import <Foundation/Foundation.h>

@class CSWork;
@class CSDoLaterProcess;

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (CSExtension)

- (id)as:(Protocol *)aProtocol;

- (instancetype)setObject:(const void *)key :(id)value;

- (instancetype)setWeakObject:(const void *)key :(id)value;

- (id)getObject:(const void *)key;

- (instancetype)addNotificationObserver:(SEL)sel name:(NSString *)name;

- (instancetype)addNotificationObserver:(SEL)sel name:(NSString *)name for:(id)object;

- (instancetype)removeNotificationObserver;

- (CSDoLaterProcess *)doLater:(void (^)(void))method;

- (CSDoLaterProcess *)doLater:(double)seconds :(void (^)(void))method;

- (CSWork *)schedule:(double)seconds :(void (^)(void))method;

- (BOOL)isKindOfOneOfClass:(NSArray *)classes;

- (NSString *)className;

+ (NSString *)className;
@end

NS_ASSUME_NONNULL_END
