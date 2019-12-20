////
////  Created by Rene Dohan on 1/11/13.
////
//
//@import BlocksKit;
//#import "CSScrollViewPagerController.h"
//#import "UIScrollView+CSExtension.h"
//#import "UIView+CSExtension.h"
//#import "UIView+CSContainer.h"
//
//@implementation CSScrollViewPagerController {
//    UIPageControl *_pageControl;
//    UIScrollView *_scrollView;
//    BOOL _pageControlUsed;
//    UIView *(^_createContentView)();
//}
//
//- (void)construct:(CSMainController *)parent :(UIPageControl *)pageControl :(UIScrollView *)scrollView :(NSUInteger)count :(UIView *(^)(void))createContentView {
//    [super construct:parent];
//    _pageControl = pageControl;
//    _pageControl.numberOfPages = count;
//    _scrollView = scrollView;
//    _scrollView.delegate = self;
//    _scrollView.pagingEnabled = YES;
//    [_pageControl bk_addEventHandler:^(id sender) {[self changePage];} forControlEvents:UIControlEventValueChanged];
//    _createContentView = [createContentView copy];
//}
//
//- (void)onViewWillAppear {
//    [_scrollView clearSubviews];
//    [_scrollView content:_createContentView()];
//    [self showPage:_pageControl.currentPage];
//}
//
//- (void)changePage {
//    _pageControlUsed = YES;
//    [self showPage:_pageControl.currentPage];
//}
//
//- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)view {
//    _pageControlUsed = NO;
//}
//
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)view {
//    if (!_pageControlUsed)
//        _pageControl.currentPage = lround(_scrollView.contentOffset.x / (_scrollView.contentSize.width / _pageControl.numberOfPages));
//}
//
//- (void)showPage:(NSInteger)index {
//    [_scrollView scrollToPage:index of:_pageControl.numberOfPages];
//}
//
//- (void)onViewWillTransitionToSizeCompletion:(CGSize)size :(id <UIViewControllerTransitionCoordinatorContext>)context {
//    [_scrollView clearSubviews];
//    [_scrollView content:_createContentView()];
//    [self showPage:_pageControl.currentPage];
//}
//
//@end
