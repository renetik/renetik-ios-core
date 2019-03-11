//
//  Created by Rene Dohan on 1/13/13.
//
#import "UIView+CSExtension.h"
#import "UIScrollView+CSExtension.h"
#import "UIView+CSPosition.h"
#import "UIView+CSDimension.h"

#import "UIView+CSAutoResizing.h"
#import "UIView+CSLayout.h"
#import "CSLang.h"

@implementation UIScrollView (CSExtension)

+ (instancetype)contentVertical :(UIView *)view {
    let instance = [self withSize :view.width :view.height];
    [instance contentVertical :view];
    return instance;
}

+ (instancetype)contentHorizontal :(UIView *)view {
    let instance = [self withSize :view.width :view.height];
    [instance contentHorizontal :view];
    return self;
}

- (void)scrollToPage :(NSInteger)toIndex of :(NSInteger)ofCount {
    CGFloat pageWidth = self.contentSize.width / ofCount;
    CGFloat x = toIndex * pageWidth;
    [self setContentOffset :CGPointMake(x, 0) animated :YES];
}

//- (void)scrollToView:(UIView *)content animated:(BOOL)animated {
//    var origin = content.superview;
//    let childStartPoint = origin ? [origin convertPoint:view.position toView:self] : content.position;
//    self.contentOffset = childStartPoint;
//    [UIView animateWithDuration:2.0f delay:0 options:UIViewAnimationOptionCurveLinear
//                     animations:^{self.contentOffset = childStartPoint;} completion:NULL];
//}

- (void)scrollToTop {
    [self scrollRectToVisible :CGRectMake(0, 0, 1, 1) animated :YES];
}

- (void)scrollToBottom {
    [self setContentOffset :CGPointMake(0, self.contentSize.height - self.bounds.size.height) animated :YES];
}

- (long)currentPageIndexFrom :(NSUInteger)from {
    return lround(self.contentOffset.x / (self.contentSize.width / from));
}

- (UIView *)content :(UIView *)view {
    [super content :view];
    self.contentSize = view.size;
    return view;
}

- (UIView *)contentVertical :(UIView *)view {
    [[super content :view].matchParentWidth top :0];
    self.updateContentSizeVertical;
    return view;
}

- (UIView *)contentHorizontal :(UIView *)view {
    [[super content :view].matchParentHeight left :0];
    self.updateContentSizeHorizontal;
    return view;
}

- (void)setContentVertical :(UIView *)view {
    [self contentVertical :view];
}

- (instancetype)contentVerticalSize :(CGFloat)size {
    [[self contentSizeVertical :size].content height :size];
    return self;
}

- (instancetype)contentSizeVertical :(CGFloat)size {
    self.contentSize = CGSizeMake(0, size);
    return self;
}

- (instancetype)updateContentSizeVertical {
    return [self updateContentSizeVerticalWithPadding :0];
}

- (instancetype)updateContentSizeVerticalWithPadding :(NSInteger)padding {
    self.content.height = self.content.subviews.lastObject.bottom + padding;
    if (self.content.height < self.height) self.content.height = self.height;
    self.contentSize = CGSizeMake(0, self.content.bottom);
    return self;
}

- (instancetype)updateContentSizeHorizontal {
    self.content.width = self.content.subviews.lastObject.right;
    self.contentSize = CGSizeMake(self.content.right, 0);
    return self;
}

- (instancetype)contentInset :(UIEdgeInsets)contentInset {
    self.contentInset = contentInset;
    if (@available(iOS 11, *)) self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    return self;
}

@end
