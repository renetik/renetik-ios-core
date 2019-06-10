//
//  Created by Rene Dohan on 1/13/13.
//
#import "CSLang.h"
#import "UIView+CSExtension.h"
#import "UIScrollView+CSExtension.h"


@implementation UIScrollView (CSExtension)

- (void)scrollToPage:(NSInteger)toIndex of:(NSInteger)ofCount {
    CGFloat pageWidth = self.contentSize.width / ofCount;
    CGFloat x = toIndex * pageWidth;
    [self setContentOffset:CGPointMake(x, 0) animated:YES];
}

- (void)scrollToTop {
	[self setContentOffset:CGPointMake(self.contentOffset.x, -self.contentInset.top) animated:YES];
}

- (void)scrollToBottom {
    [self setContentOffset:CGPointMake(0, self.contentSize.height - self.bounds.size.height) animated:YES];
}

- (void)sizeHeightToFit {
    UIEdgeInsets inset = self.contentInset;
    self.height = self.contentSize.height + inset.top + inset.bottom;
}

- (long)currentPageIndexFrom:(NSUInteger)from {
    return lround(self.contentOffset.x / (self.contentSize.width / from));
}

- (instancetype)fixScrollViewContentInsets:(UINavigationController *)navigation {
    if (@available(iOS 11, *)){
        self.contentInset = UIEdgeInsetsMake(navigation.navigationBar.bottom, 0, 0, 0);
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    return self;
}
@end
