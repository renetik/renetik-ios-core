//
//  Created by Rene Dohan on 4/29/12.
//


#import <Foundation/Foundation.h>

@class CSWork;
@class CSDoLaterProcess;

@interface NSObject (CSExtension)

+ (instancetype _Nonnull)construct;

- (instancetype _Nonnull)construct;

- (id)as:(Protocol *)aProtocol;

- (instancetype _Nonnull)setObject:(const void *)key :(id)value;

- (id)getObject:(const void *)key;

- (instancetype _Nonnull)addNotificationObserver:(SEL)sel name:(NSString *)name;

- (instancetype _Nonnull)addNotificationObserver:(SEL)sel name:(NSString *)name for:(id)object;

- (instancetype _Nonnull)removeNotificationObserver;

- (CSDoLaterProcess *_Nonnull)doLater:(void (^)(void))method;

- (CSDoLaterProcess *_Nonnull)doLater:(double)seconds :(void (^)(void))method;

- (CSWork *_Nonnull)schedule:(double)seconds :(void (^)(void))method;

- (BOOL)isKindOfOneOfClass:(NSArray *)classes;

- (NSString *_Nonnull)className;

+ (NSString *_Nonnull)className;


@end
