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
    CGFloat fixedWidth = self.frame.size.width;
    CGSize newSize = [self sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    CGRect newFrame = self.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    self.frame = newFrame;
}

- (long)currentPageIndexFrom:(NSUInteger)from {
    return lround(self.contentOffset.x / (self.contentSize.width / from));
}

- (instancetype)fixScrollViewContentInsets:(UINavigationController *)navigation {
    if (@available(iOS 11, *)) {
        self.contentInset = UIEdgeInsetsMake(navigation.navigationBar.bottom, 0, 0, 0);
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    return self;
}

- (instancetype)setContent:(UIView *)view {
    [self addView:view];
    self.contentSize = view.frame.size;
    return self;
}

- (UIView *)content {
    return self.subviews.firstObject;
}
@end
