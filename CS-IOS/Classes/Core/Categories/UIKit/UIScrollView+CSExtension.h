//  Created by Rene Dohan on 1/13/13.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (CSExtension)

+ (instancetype)contentVertical:(UIView *)view;

+ (instancetype)contentHorizontal:(UIView *)view;

- (UIView *)contentVertical:(UIView *)view;

- (UIView *)contentHorizontal:(UIView *)view;

- (void)scrollToPage:(NSInteger)toIndex of:(NSInteger)ofCount;

- (void)scrollToTop;

- (void)scrollToBottom;

- (instancetype)sizeHeightToFit;

- (long)currentPageIndexFrom:(NSUInteger)from;

- (instancetype)fixScrollViewContentInsets:(UINavigationController *)navigation;

- (void)setContentVertical:(UIView *)view;

- (instancetype)updateContentSizeVertical;

- (instancetype)updateContentSizeHorizontal;
@end