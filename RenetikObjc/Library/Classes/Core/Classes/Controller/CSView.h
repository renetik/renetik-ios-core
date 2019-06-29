//
// Created by Rene Dohan on 25/07/18.
//

@import UIKit;

@interface CSView : UIView

@property(nonatomic, copy) void (^onLayoutSubviews)();

- (void)layoutSubviews;

@end
