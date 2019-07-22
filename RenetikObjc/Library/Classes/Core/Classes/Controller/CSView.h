//
// Created by Rene Dohan on 25/07/18.
//

@import UIKit;

@interface CSView: UIView

- (void)executeToUpdateHeight:(void (^)())onUpdateHeight;

- (void)onLayoutSubviews;

@end
