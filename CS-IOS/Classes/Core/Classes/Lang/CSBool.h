//
//  Created by Rene Dohan on 5/12/12.
//


#import <Foundation/Foundation.h>


@interface CSBool : NSNumber

+ (CSBool *)newBool:(BOOL)value;

- (BOOL)value;

@end