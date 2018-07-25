//
//  Created by Rene Dohan on 1/13/13.
//
#import "UIView+CSExtension.h"
#import "UIScrollView+CSExtension.h"
#import "UIView+CSPosition.h"
#import "UIView+CSDimension.h"
#import "CSLang.h"

@implementation UIScrollView (CSExtension)

- (void)scrollToPage:(NSInteger)toIndex of:(NSInteger)ofCount {
    CGFloat pageWidth = self.contentSize.width / ofCount;
    CGFloat x = toIndex * pageWidth;
    [self setContentOffset:CGPointMake(x, 0) animated:YES];
}

//- (void)scrollToView:(UIView *)content animated:(BOOL)animated {
//    var origin = content.superview;
//    let childStartPoint = origin ? [origin convertPoint:view.position toView:self] : content.position;
//    self.contentOffset = childStartPoint;
//    [UIView animateWithDuration:2.0f delay:0 options:UIViewAnimationOptionCurveLinear
//                     animations:^{self.contentOffset = childStartPoint;} completion:NULL];
//}

- (void)scrollToTop {
    [self scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}

- (void)scrollToBottom {
    [self setContentOffset:CGPointMake(0, self.contentSize.height - self.bounds.size.height) animated:YES];
}

- (instancetype)sizeHeightToFit {
    CGFloat fixedWidth = self.frame.size.width;
    CGSize newSize = [self sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    CGRect newFrame = self.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    self.frame = newFrame;
    return self;
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

- (UIView *)content:(UIView *)view {
    [self insertView:view :0];
    self.contentSize = view.size;
    return view;
}

- (UIView *)contentVertical:(UIView *)view {
    [self insertView:view :0].matchParentWidth;
    self.updateContentSizeVertical;
    return view;
}

- (UIView *)contentHorizontal:(UIView *)view {
    [self insertView:view :0].matchParentHeight;
    self.updateContentSizeHorizontal;
    return view;
}

- (void)setContentVertical:(UIView *)view {
    [self contentVertical:view];
}

+ (instancetype)contentVertical:(UIView *)view {
    val scrollView = [self withSize:view.width :view.height];
    [[scrollView contentVertical:view] top:0].matchParentWidth;
    return scrollView;
}

+ (instancetype)contentHorizontal:(UIView *)view {
    val scrollView = [self withSize:view.width :view.height];
    [[scrollView contentHorizontal:view] left:0].matchParentHeight;
    return scrollView;
}

- (instancetype)updateContentSizeVertical {
    self.contentSize = CGSizeMake(0, self.content.bottom);
    return self;
}

- (instancetype)updateContentSizeHorizontal {
    self.contentSize = CGSizeMake(self.content.right, 0);
    return self;
}
@end
