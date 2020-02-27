//
//  Created by Rene Dohan on 10/24/12.
//

@import UIKit;

@interface CSTableViewCell: UITableViewCell

- (void)executeToUpdateHeight:(void (^)())onUpdateHeight;

- (void)onLayoutSubviews;

@end
