//
//  Created by Rene Dohan on 1/11/13.
//

@import UIKit;

#import "CSChildViewLessController.h"

@class CSMainController;

@interface CSScrollViewPager : CSChildViewLessController <UIScrollViewDelegate>

- (void)construct:(CSMainController *)parent :(UIPageControl *)pageControl :(UIScrollView *)scrollView :(NSUInteger)count :(UIView *(^)(void))pFunction;

- (void)showPage:(NSInteger)index;

@end
