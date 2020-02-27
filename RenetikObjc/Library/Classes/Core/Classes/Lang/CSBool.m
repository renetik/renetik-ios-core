//
//  Created by Rene Dohan on 5/12/12.
//


#import "CSBool.h"

@implementation CSBool
+ (CSBool *)construct:(BOOL)value {
    CSBool *this = [self new];
    this.value = value;
    return this;
}
@end