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

- (void)addContentView:(UIView *)view;
@end