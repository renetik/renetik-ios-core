//  Created by Rene Dohan on 1/13/13.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (CSExtension)

+ (instancetype)contentVertical:(UIView *)view;

+ (instancetype)contentHorizontal:(UIView *)view;

- (UIView *)contentVertical:(UIView *)view;

- (UIView *)contentHorizontal:(UIView *)view;

- (void)scrollToPage:(NSInteger)toIndex of:(NSInteger)ofCount;

- (void)scrollToTop;

- (void)scrollToBottom;

- (long)currentPageIndexFrom:(NSUInteger)from;

- (void)setContentVertical:(UIView *)view;

- (instancetype)contentVerticalSize:(CGFloat)size;

- (instancetype)contentSizeVertical:(CGFloat)size;

- (instancetype)updateContentSizeVertical;

- (instancetype)updateContentSizeHorizontal;

- (instancetype)contentInset:(UIEdgeInsets)contentInset;
@end