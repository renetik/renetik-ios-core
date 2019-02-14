//
// Created by inno on 2/2/13.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import "CSLang.h"

#import "UIFont+CSExtension.h"


@implementation UIFont (CSExtension)

- (void)setTo:(NSArray *)items {
    for (id item in items)
        [item setFont:self];
}

@end
