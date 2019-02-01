//
//  Created by Rene Dohan on 5/7/12.
//
#import "CSLang.h"
#import "UIView+CSExtension.h"
#import "UITableViewCell+CSExtension.h"


@implementation UITableViewCell (CSExtension)


- (void)setBackgroundViewColor:(UIColor *)color {
    self.backgroundView = [UIView withColor:color];
}

- (void)setSelectedBackgroundColor:(UIColor *)color {
    self.selectedBackgroundView = [UIView withColor:color];;
}

- (UIView *)cellView {
	return self.contentView.content;
}

@end
