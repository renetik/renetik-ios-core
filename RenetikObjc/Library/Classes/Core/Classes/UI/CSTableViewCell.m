//
//  Created by Rene Dohan on 10/24/12.
//

#import "CSTableViewCell.h"
#import "CSLang.h"

@interface CSTableViewCell ()
@property (nonatomic, copy) void (^ onUpdateHeight)();
@end

@implementation CSTableViewCell

- (void)layoutSubviews {
    super.layoutSubviews;
    run(self.onLayoutSubviews);
    run(self.onUpdateHeight);
}

- (void)executeToUpdateHeight:(void (^)())onUpdateHeight {
    run(onUpdateHeight);
	self.onUpdateHeight = onUpdateHeight;
}

- (NSString*)reuseIdentifier {
    if(super.reuseIdentifier) return super.reuseIdentifier;
    return self.class.description;
}

@end
