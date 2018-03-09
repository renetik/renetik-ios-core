//
//  Created by Rene Dohan on 4/29/12.
//


#import <Foundation/Foundation.h>

@class CSWork;
@class CSDoLaterProcess;

@interface NSObject (CSExtension)

- (instancetype)construct;

- (CSDoLaterProcess *)doLater:(void (^)(void))method;

- (CSDoLaterProcess *)doLater:(double)seconds :(void (^)(void))method;

- (CSWork *)schedule:(double)seconds :(void (^)(void))method;

- (void)addNotificationCenterObserver:(SEL)sel name:(NSString *)name;

- (void)addNotificationCenterObserver:(SEL)sel name:(NSString *)name for:(id)object;

- (BOOL)isKindOfOneOfClass:(NSArray *)classes;

- (void)removeNotificationObserver;

- (NSString *)className;

+ (NSString *)className;

@end
