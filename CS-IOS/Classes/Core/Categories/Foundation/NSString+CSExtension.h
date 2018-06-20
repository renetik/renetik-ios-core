//
//  Created by Rene Dohan on 4/29/12.
//


#import <Foundation/Foundation.h>

@interface NSString (CSExtension)

- (NSString *)remove:(NSString *)string;

- (NSString *)removeEnd:(NSString *)string;

- (NSString *)substringTo:(NSUInteger)to;

- (NSString *)add:(NSObject *)first;

- (NSString *)add:(NSObject *)first :(NSObject *)second;

- (NSString *)add:(NSObject *)first :(NSObject *)second :(NSObject *)third;

- (NSString *)add:(NSObject *)first :(NSObject *)second :(NSObject *)third :(NSObject *)fourth;

- (NSString *)add:(NSObject *)first :(NSObject *)second :(NSObject *)third :(NSObject *)fourth :(NSObject *)fifth;

- (NSString *)add:(NSObject *)first :(NSObject *)second :(NSObject *)third :(NSObject *)fourth :(NSObject *)fifth :(NSObject *)sixth;

- (NSString *)add:(NSObject *)first :(NSObject *)second :(NSObject *)third :(NSObject *)fourth :(NSObject *)fifth :(NSObject *)sixth :(NSObject *)seventh;

- (NSString *)add:(NSObject *)first :(NSObject *)second :(NSObject *)third :(NSObject *)fourth :(NSObject *)fifth :(NSObject *)sixth :(NSObject *)seventh :(NSObject *)param8;

- (NSString *)add:(NSObject *)first :(NSObject *)second :(NSObject *)third :(NSObject *)fourth :(NSObject *)fifth :(NSObject *)sixth :(NSObject *)seventh :(NSObject *)param8 :(NSObject *)param9;

- (NSString *)add:(NSObject *)first :(NSObject *)second :(NSObject *)third :(NSObject *)fourth :(NSObject *)fifth :(NSObject *)sixth :(NSObject *)seventh :(NSObject *)param8 :(NSObject *)param9 :(NSObject *)param10;

- (NSString *)add:(NSObject *)first :(NSObject *)second :(NSObject *)third :(NSObject *)fourth :(NSObject *)fifth :(NSObject *)sixth :(NSObject *)seventh :(NSObject *)param8 :(NSObject *)param9 :(NSObject *)param10 :(NSObject *)param11;


+ (NSString *)fromInt:(NSInteger)value;

+ (NSString *)fromBool:(BOOL)value;

+ (NSString *)fromDbl:(double)value;

+ (NSString *)fromFile:(NSString *)path;

- (id)JSONObject;

- (uint)uintValue;

+ (NSString *)randomStringOfLength:(int)len;

+ (NSString *)format:(NSString *)format :(NSObject *)argument;

+ (NSString *)format:(NSString *)format :(NSObject *)argument :(NSObject *)argument2;

+ (NSString *)format:(NSString *)format :(NSObject *)argument :(NSObject *)argument2 :(NSObject *)argument3;

+ (NSString *)format:(NSString *)format :(NSObject *)argument :(NSObject *)argument2 :(NSObject *)argument3 :(NSObject *)argument4;

+ (NSString *)format:(NSString *)format :(NSObject *)argument :(NSObject *)argument2 :(NSObject *)argument3 :(NSObject *)argument4 :(NSObject *)argument5;

- (NSString *)clearLast:(NSInteger)count;

+ (BOOL)empty:(NSString *)string;

+ (BOOL)set:(NSString *)string;

- (NSString *)replaceLast:(NSString *)string :(NSString *)replacement;

- (BOOL)set;

- (BOOL)empty;

- (NSString *)trim;

- (BOOL)equals:(NSString *)aString;

- (BOOL)equalsOr:(NSArray<NSString *> *)array;

- (BOOL)equalsAnd:(NSArray<NSString *> *)array;

- (BOOL)contains:(NSString *)string;

- (NSArray<NSString *> *)split:(NSString *)string;

- (BOOL)containsNoCase:(NSString *)string;

- (BOOL)contains:(NSString *)string :(NSStringCompareOptions)options;

- (NSString *)replace:(NSString *)string :(NSString *)replacement;

- (int)indexOf:(NSString *)string;

- (uint)countString:(NSString *)string;
@end