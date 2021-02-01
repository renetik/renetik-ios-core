////
////  Created by Rene Dohan on 5/7/12.
////
//#import "CSLang.h"
//#import "NSUserDefaults+CSExtension.h"
//
//
//@implementation NSUserDefaults (CSExtension)
//
//+ (void)save:(NSString *)key :(id)object {
//    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
//}
//
//+ (void)clear:(NSString *)key {
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
//}
//
//+ (id)loadObject:(NSString *)key {
//    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
//}
//
//+ (id)loadObject:(NSString *)key :(id)defaultValue {
//    id value = [NSUserDefaults loadObject:key];
//    return !value ? defaultValue : value;
//}
//
//+ (NSInteger)loadInteger:(NSString *)key {
//    return [NSUserDefaults.standardUserDefaults integerForKey:key];
//}
//
//+ (NSString *)loadString:(NSString *)key {
//    return [NSUserDefaults.standardUserDefaults stringForKey:key];
//}
//
//+ (NSString *)loadString:(NSString *)key:(NSString*)defaultValue  {
//    if (![self hasKey:key]) return defaultValue;
//    return [NSUserDefaults.standardUserDefaults stringForKey:key];
//}
//
//+ (NSInteger)loadInteger:(NSString *)key :(NSInteger)defaultValue {
//    if (![self hasKey:key]) return defaultValue;
//    return [NSUserDefaults.standardUserDefaults integerForKey:key];
//}
//
//+ (BOOL)hasKey:(NSString *)key {
//    return [NSUserDefaults.standardUserDefaults objectForKey:key] != nil;
//}
//
//+ (NSUInteger)loadUInteger:(NSString *)key {
//    return (NSUInteger) [NSUserDefaults.standardUserDefaults integerForKey:key];
//}
//
//+ (void)saveInteger:(NSString *)key :(NSInteger)value {
//    return [NSUserDefaults.standardUserDefaults setInteger:value forKey:key];
//}
//
//+ (float)loadFloat:(NSString *)key {
//    return [NSUserDefaults.standardUserDefaults floatForKey:key];
//}
//
//+ (double)loadDouble:(NSString *)key {
//    return [NSUserDefaults.standardUserDefaults doubleForKey:key];
//}
//
//+ (BOOL)loadBOOL:(NSString *)key {
//    return [NSUserDefaults.standardUserDefaults boolForKey:key];
//}
//
//+ (void)saveBOOL:(NSString *)key :(BOOL)value {
//    return [NSUserDefaults.standardUserDefaults setBool:value forKey:key];
//}
//
//+ (BOOL)synchronize {
//    return [[NSUserDefaults standardUserDefaults] synchronize];
//}
//
//@end
