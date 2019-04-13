//
//  Created by Rene Dohan on 5/7/12.
//
#import "CSLang.h"
#import "UIView+CSExtension.h"
#import "UITableViewCell+CSExtension.h"
#import "UIView+CSContainer.h"

@implementation UITableViewCell (CSExtension)

- (instancetype)construct {
    super.construct;
    self.backgroundColor = UIColor.clearColor;
    [self setSelectedBackgroundColor :UIColor.clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
    return self;
}

- (void)setBackgroundViewColor :(UIColor *)color {
    self.backgroundView = [UIView withColor :color];
}

- (void)setSelectedBackgroundColor :(UIColor *)color {
    self.selectedBackgroundView = [UIView withColor :color];
}

- (UIView *)cellView {
    return self.contentView.content;
}

@end
