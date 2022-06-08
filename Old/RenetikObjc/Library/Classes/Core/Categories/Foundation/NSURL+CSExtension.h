//
//  Created by Rene Dohan on 12/19/12.
//

@import Foundation;

@interface NSURL (CSExtension)

+ (NSString *)createParamsString:(NSDictionary *)dictionary;

- (BOOL)validate;

- (NSURL *)URLByAppending:(NSString *)path;

- (NSString *)parseBaseURL;

+ (NSString *)urlEncode:(NSString *)urlString;
@end