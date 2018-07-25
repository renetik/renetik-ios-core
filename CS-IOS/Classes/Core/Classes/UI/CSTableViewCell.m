//
//  Created by Rene Dohan on 10/24/12.
//


#import "CSTableViewCell.h"


@implementation CSTableViewCell {

}

- (void)layoutSubviews {
    super.layoutSubviews;
    runWith(self.onLayoutSubviews, self);
}

- (NSString *)reuseIdentifier {
    if (super.reuseIdentifier)return super.reuseIdentifier;
    return self.class.description;
}

@end
