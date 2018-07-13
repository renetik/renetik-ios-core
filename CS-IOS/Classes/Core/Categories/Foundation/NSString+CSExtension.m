//
//  Created by Rene Dohan on 4/29/12.
//
#import "NSString+CSExtension.h"


@implementation NSString (CSExtension)

static NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

- (uint)uintValue {
    return (uint) self.integerValue;
}

+ (NSString *)randomStringOfLength:(int)len {
    NSMutableString *randomString = [NSMutableString stringWithCapacity:(NSUInteger) len];
    for (int i = 0; i < len; i++) {
        [randomString appendFormat:@"%C", [letters characterAtIndex:arc4random() % [letters length]]];
    }
    return randomString;
}

+ (NSString *)format:(NSString *)format :(NSObject *)argument {
    return [NSString format:format :argument :nil];
}

+ (NSString *)format:(NSString *)format :(NSObject *)argument :(NSObject *)argument2 {
    return [NSString format:format :argument :argument2 :nil];
}

+ (NSString *)format:(NSString *)format :(NSObject *)argument :(NSObject *)argument2 :(NSObject *)argument3 {
    return [NSString format:format :argument :argument2 :argument3 :nil];
}

+ (NSString *)format:(NSString *)format :(NSObject *)argument :(NSObject *)argument2 :(NSObject *)argument3 :(NSObject *)argument4 {
    return [NSString format:format :argument :argument2 :argument3 :argument4 :nil];
}

+ (NSString *)format:(NSString *)format :(NSObject *)argument :(NSObject *)argument2
        :(NSObject *)argument3 :(NSObject *)argument4 :(NSObject *)argument5 {
    return [NSString stringWithFormat:format,
                                      argument ? argument.description : @"",
                                      argument2 ? argument2.description : @"",
                                      argument3 ? argument3.description : @"",
                                      argument4 ? argument4.description : @"",
                                      argument5 ? argument5.description : @"",
                    nil];
}

- (NSString *)clearLast:(NSInteger)count {
    if (count > self.length)return self;
    return [self substringToIndex:self.length - count];
}

- (NSString *)replaceLast:(NSString *)string :(NSString *)replacement {
    if ([self contains:string])
        return [self stringByReplacingCharactersInRange:[self rangeOfString:string options:NSBackwardsSearch] withString:replacement];
    return self;
}

- (NSString *)replace:(NSString *)string :(NSString *)replacement {
    return [self stringByReplacingOccurrencesOfString:string withString:replacement];
}

- (NSString *)remove:(NSString *)string {
    return [self replace:string :@""];
}

- (NSString *)removeEnd:(NSString *)string {
    return [self replaceLast:string :@""];
}

- (NSString *)substringTo:(NSUInteger)to {
    if (to > self.length)return self;
    return [self substringToIndex:to];
}

- (NSString *)add:(NSObject *)first {
    if (!first)return self;
    NSString *description = first.description;
    if (description) return [self stringByAppendingString:description];
    return self;
}

- (NSString *)add:(NSObject *)first :(NSObject *)second {
    return [[self add:first] add:second];
}

- (NSString *)add:(NSObject *)first :(NSObject *)second :(NSObject *)third {
    return [[self add:first :second] add:third];
}

- (NSString *)add:(NSObject *)first :(NSObject *)second :(NSObject *)third :(NSObject *)fourth {
    return [[self add:first :second :third] add:fourth];
}

- (NSString *)add:(NSObject *)first :(NSObject *)second :(NSObject *)third :(NSObject *)fourth :(NSObject *)fifth {
    return [[self add:first :second :third :fourth] add:fifth];
}

- (NSString *)add:(NSObject *)first :(NSObject *)second :(NSObject *)third :(NSObject *)fourth :(NSObject *)fifth :(NSObject *)sixth {
    return [[self add:first :second :third :fourth :fifth] add:sixth];
}

- (NSString *)add:(NSObject *)first :(NSObject *)second :(NSObject *)third :(NSObject *)fourth :(NSObject *)fifth :(NSObject *)sixth :(NSObject *)seventh {
    return [[self add:first :second :third :fourth :fifth :sixth] add:seventh];
}

- (NSString *)add:(NSObject *)first :(NSObject *)second :(NSObject *)third :(NSObject *)fourth :(NSObject *)fifth :(NSObject *)sixth :(NSObject *)seventh :(NSObject *)param8 {
    return [[self add:first :second :third :fourth :fifth :sixth :seventh] add:param8];
}

- (NSString *)add:(NSObject *)first :(NSObject *)second :(NSObject *)third :(NSObject *)fourth :(NSObject *)fifth
        :(NSObject *)sixth :(NSObject *)seventh :(NSObject *)param8 :(NSObject *)param9 {
    return [[self add:first :second :third :fourth :fifth :sixth :seventh :param8] add:param9];
}

- (NSString *)add:(NSObject *)first :(NSObject *)second :(NSObject *)third :(NSObject *)fourth :(NSObject *)fifth
        :(NSObject *)sixth :(NSObject *)seventh :(NSObject *)param8 :(NSObject *)param9 :(NSObject *)param10 {
    return [[self add:first :second :third :fourth :fifth :sixth :seventh :param8 :param9] add:param10];
}

- (NSString *)add:(NSObject *)first :(NSObject *)second :(NSObject *)third :(NSObject *)fourth :(NSObject *)fifth
        :(NSObject *)sixth :(NSObject *)seventh :(NSObject *)param8 :(NSObject *)param9 :(NSObject *)param10 :(NSObject *)param11 {
    return [[self add:first :second :third :fourth :fifth :sixth :seventh :param8 :param9 :param10] add:param11];
}

+ (NSString *)fromInt:(NSInteger)value {
    return [NSString stringWithFormat:@"%ld", (long) value];
}

+ (NSString *)fromDbl:(double)value {
    return [NSString stringWithFormat:@"%f", value];
}

+ (NSString *)fromBool:(BOOL)value {
    return [NSString stringWithFormat:@"%s", value ? "YES" : "NO"];
}

- (BOOL)contains:(NSString *)string {
    return [self rangeOfString:string].location != NSNotFound;
}

- (NSArray<NSString *> *)split:(NSString *)string {
    return [self componentsSeparatedByString:string];
}

- (BOOL)containsNoCase:(NSString *)string {
    return [self rangeOfString:string options:NSCaseInsensitiveSearch].location != NSNotFound;
}

- (BOOL)contains:(NSString *)string :(NSStringCompareOptions)options {
    return [self rangeOfString:string options:options].location != NSNotFound;
}

- (BOOL)set {
    return self.length != 0;
}

- (BOOL)empty {
    return self.length == 0;
}

- (NSString *)trim {
    return [self stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
}

- (BOOL)equals:(NSString *)aString {
    return [self isEqualToString:aString];
}

- (BOOL)equalsOr:(NSArray<NSString *> *)array {
    for (NSString *string in array)
        if ([self equals:string]) return YES;
    return NO;
}

- (BOOL)equalsAnd:(NSArray<NSString *> *)array {
    for (NSString *string in array)
        if (![self equals:string]) return NO;
    return YES;
}

+ (NSString *)fromFile:(NSString *)path {
    return [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
}

- (id)jsonValue {
    return [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding]
                                           options:NSJSONReadingMutableContainers | NSJSONReadingAllowFragments
                                             error:nil];
}

+ (BOOL)empty:(NSString *)string {
    return string == nil || string.empty;
}

+ (BOOL)set:(NSString *)string {
    return ![self empty:string];
}

- (int)indexOf:(NSString *)string {
    return [self rangeOfString:string].location;
}

- (uint)countString:(NSString *)string {
    return [self split:string].count - 1;
}

@end
