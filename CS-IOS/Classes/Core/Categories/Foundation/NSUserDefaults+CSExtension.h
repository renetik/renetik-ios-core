//
//  Created by Rene Dohan on 5/7/12.
//


#import <Foundation/Foundation.h>

@interface NSUserDefaults (CSExtension)

+ (void)save:(NSString *)key :(id)object;

+ (void)clear:(NSString *)key;

+ (id)load:(NSString *)key;

+ (id)load:(NSString *)key :(id)defaultValue;

+ (NSInteger)loadInteger:(NSString *)key;

+ (NSString *)loadString:(NSString *)key;

+ (NSInteger)loadInteger:(NSString *)key :(NSInteger)defaultValue;

+ (BOOL)hasKey:(NSString *)key;

+ (NSUInteger)loadUInteger:(NSString *)key;

+ (void)saveInteger:(NSString *)key :(NSInteger)value;

+ (float)loadFloat:(NSString *)key;

+ (double)loadDouble:(NSString *)key;

+ (BOOL)loadBOOL:(NSString *)key;

+ (void)saveBOOL:(NSString *)key :(BOOL)value;

+ (BOOL)synchronize;
@end