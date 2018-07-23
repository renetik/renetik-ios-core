//
//  Created by Rene Dohan on 1/12/13.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UITextView (CSExtension)


- (void)setHtmlWithViewFontSize:(NSString *)string;

- (instancetype)scrollToCursorPosition;

- (instancetype)asLabel;

+ (void)hideTextInsets:(NSArray<UITextView *> *)textViews;

@end