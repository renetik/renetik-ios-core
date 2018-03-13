//
//  Created by Rene Dohan on 1/12/13.
//
#import "CSLang.h"
#import "NSIndexPath+CSExtension.h"

@implementation NSIndexPath (CSExtension)

- (NSUInteger)index {
    return (NSUInteger) self.row;
}

- (NSUInteger)uSection {
    return (NSUInteger) self.section;
}

+ (instancetype)indexPathForRow:(uint)index {
    return [NSIndexPath indexPathForRow:index inSection:0];
}

@end
