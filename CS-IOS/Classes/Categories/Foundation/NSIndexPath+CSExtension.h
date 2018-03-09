//
//  Created by Rene Dohan on 1/12/13.
//

#import <UIKit/UIKit.h>

@interface NSIndexPath (CSExtension)

+ (instancetype)indexPathForRow:(uint)index;

- (NSUInteger)index;

- (NSUInteger)uSection;

@end