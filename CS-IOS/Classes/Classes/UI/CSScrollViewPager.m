//
//  Created by Rene Dohan on 1/11/13.
//


#import "CSScrollViewPager.h"

@implementation CSScrollViewPager {
    UIPageControl *_pageControl;
    UIScrollView *_scrollView;
    BOOL _pageControlUsed;
}

- (CSScrollViewPager *)with:(UIPageControl *)control :(UIScrollView *)scrollView {
    _pageControl = control;
    _scrollView = scrollView;
    [_pageControl addTarget:self action:@selector(changePage) forControlEvents:UIControlEventValueChanged];
    return self;
}

- (CSScrollViewPager *)withScrollViewDelegate:(UIPageControl *)control :(UIScrollView *)scrollView {
    scrollView.delegate = self;
    return [self with:control :scrollView];
}

- (void)changePage {
    _pageControlUsed = YES;
    [self showPage:_pageControl.currentPage];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)view {
    _pageControlUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)view {
    if (!_pageControlUsed)
        _pageControl.currentPage = lround(_scrollView.contentOffset.x / (_scrollView.contentSize.width / _pageControl.numberOfPages));
}

- (void)showPage:(NSInteger)index {
    [_scrollView scrollToPage:index of:_pageControl.numberOfPages];
}
@end