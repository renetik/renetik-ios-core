//
// Created by Rene Dohan on 25/07/18.
//

#import "CSView.h"
#import "CSLang.h"

@implementation CSView

- (void)layoutSubviews {
    super.layoutSubviews;
    run(self.onLayoutSubviews);
}

@end
