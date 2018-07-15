//
//  Created by Rene Dohan on 1/13/13.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (CSExtension)

- (void)scrollToPage:(NSInteger)toIndex of:(NSInteger)ofCount;

- (void)scrollToTop;

- (void)scrollToBottom;

- (void)sizeHeightToFit;

- (long)currentPageIndexFrom:(NSUInteger)from;

- (instancetype)fixScrollViewContentInsets:(UINavigationController *)navigation;

- (instancetype)setContent:(UIView *)view;

- (UIView *)content;
@end