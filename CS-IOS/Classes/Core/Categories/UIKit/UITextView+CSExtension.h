//
//  Created by Rene Dohan on 1/12/13.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UITextView (CSExtension)


- (void)setHTMLWithViewFontSize:(NSString *)string;

- (instancetype)scrollToCursorPosition;

+ (void)hideTextInsets:(NSArray<UITextView *> *)textViews;

+ (void)asLabel:(NSArray<UITextView *> *)textViews;
@end