//
//  Created by Rene Dohan on 5/12/12.
//


#import "CSBool.h"

@interface CSBool ()
@property NSNumber *number;
@end

@implementation CSBool

@synthesize number;

+ (CSBool *)newBool:(BOOL)value {
    CSBool *this = [self new];
    this.number = @(value);
    return this;
}

- (BOOL)value {
    return [number boolValue];
}

@end