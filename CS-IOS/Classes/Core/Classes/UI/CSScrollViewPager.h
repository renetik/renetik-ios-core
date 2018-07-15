//
//  Created by Rene Dohan on 1/11/13.
//

@import UIKit;

#import "CSMainController.h"
#import "CSChildViewLessController.h"

@interface CSScrollViewPager : CSChildViewLessController <UIScrollViewDelegate>

- (void)construct:(CSMainController *)parent :(UIPageControl *)pageControl :(UIScrollView *)scrollView :(NSUInteger)count :(UIView *(^)(void))pFunction;

- (void)showPage:(NSInteger)index;

@end
