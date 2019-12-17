//
// Created by Rene Dohan on 25/07/18.
//

#import "CSView.h"
#import "CSLang.h"

@interface CSView ()
@property (nonatomic, copy) void (^ onUpdateHeight)();
@end
@implementation CSView

- (void)layoutSubviews {
    super.layoutSubviews;
	self.onLayoutSubviews;
    run(self.onUpdateHeight);
}

- (void)onLayoutSubviews {

}

- (void)executeToUpdateHeight:(void (^)())onUpdateHeight {
    run(onUpdateHeight);
    self.onUpdateHeight = onUpdateHeight;
}

@end
