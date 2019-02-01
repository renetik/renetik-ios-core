//
//  Created by Rene Dohan on 10/24/12.
//

@import UIKit;

@interface CSTableViewCell : UITableViewCell

@property(nonatomic, copy) void (^onLayoutSubviews)(UITableViewCell *);

- (void)layoutSubviews;

@end
