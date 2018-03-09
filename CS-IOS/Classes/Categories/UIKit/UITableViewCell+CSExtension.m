//
//  Created by Rene Dohan on 5/7/12.
//
#import "CSLang.h"
#import "UIView+CSExtension.h"
#import "UITableViewCell+CSExtension.h"


@implementation UITableViewCell (CSExtension)


- (void)setBackgroundViewColor:(UIColor *)color {
    self.backgroundView = [UIView createEmptyWithColor:color];
}

- (void)setSelectedBackgroundColor:(UIColor *)color {
    self.selectedBackgroundView = [UIView createEmptyWithColor:color];;
}

- (UIView *)view {
    return self.contentView.subviews[0];
}
@end
