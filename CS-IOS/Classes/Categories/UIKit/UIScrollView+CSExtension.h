//
//  Created by Rene Dohan on 1/13/13.
//


#import <Foundation/Foundation.h>

@interface UIScrollView (CSExtension)

- (void)scrollToPage:(NSInteger)toIndex of:(NSInteger)ofCount;

- (void)scrollToTop;

- (void)scrollToBottom;

- (void)sizeHeightToFit;

- (long)currentPageIndexFrom:(NSUInteger)from;

@end