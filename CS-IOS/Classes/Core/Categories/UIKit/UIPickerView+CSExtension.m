//
//  Created by Rene Dohan on 10/22/12.
//

#import "UIPickerView+CSExtension.h"
#import "UIView+CSDimension.h"

@implementation UIPickerView (CSExtension)

- (void)selectRow:(NSUInteger)row {
    [self selectRow:row inComponent:0 animated:YES];
}

- (UILabel *)createCenteredLabel:(NSString *)text height:(int)height {
    UILabel *label = [self createCenteredLabelWithHeight:height];
    label.text = text;
    return label;
}

- (UILabel *)createCenteredLabelWithHeight:(int)height {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, height)];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    return label;
}

@end
