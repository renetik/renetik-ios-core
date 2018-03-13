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
    [self scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
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
@end
