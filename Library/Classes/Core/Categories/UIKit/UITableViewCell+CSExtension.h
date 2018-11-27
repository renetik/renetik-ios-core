//
//  Created by Rene Dohan on 5/7/12.
//


#import <Foundation/Foundation.h>

@interface UITableViewCell (CSExtension)

- (void)setBackgroundViewColor:(UIColor *)color;

- (void)setSelectedBackgroundColor:(UIColor *)color;

- (UIView *)content;
@end