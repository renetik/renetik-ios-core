//
//  Created by Rene Dohan on 4/29/12.
//


#import <Foundation/Foundation.h>

@class CSWork;
@class CSDoLaterProcess;

@interface NSObject (CSExtension)

- (instancetype)construct;

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
