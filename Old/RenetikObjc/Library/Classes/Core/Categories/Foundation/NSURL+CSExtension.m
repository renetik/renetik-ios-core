//
//  Created by Rene Dohan on 12/19/12.
//


#import "NSURL+CSExtension.h"
#import "NSString+CSExtension.h"
#import "CSLang.h"
#import "NSDictionary+CSExtension.h"


@implementation NSURL (CSExtension)

- (NSURL *)URLByAppending:(NSString *)path {
    return [NSURL URLWithString:[self.description add:path]];
}

- (BOOL)validate {
    return self.scheme && self.host;
}

- (NSString *)parseBaseURL {
    return [self.absoluteString stringByReplacingOccurrencesOfString:self.path withString:@""];
}

+ (NSString *)urlEncode:(NSString *)urlString {
    return [urlString stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
}

+ (NSString *)createParamsString:(NSDictionary *)dictionary {
    NSString *paramsString = @"";
    if (dictionary.count) {
        paramsString = [paramsString add:@"?"];
        for (NSString *key in dictionary)
            paramsString = [paramsString add:(key) :@"=" :((NSObject *) [dictionary get:key]).description :@"&"];
        paramsString = [paramsString substringToIndex:paramsString.length - 1];
    }
    return paramsString;
}

@end
