//
//  Created by Rene Dohan on 1/12/13.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UITextView (CSExtension)


- (instancetype)scrollToCursorPosition;

- (instancetype)dataDetector:(UIDataDetectorTypes)dataDetectorTypes;

- (instancetype)text:(NSString *)text;

- (instancetype)asLabel;

- (instancetype)construct;

- (instancetype)setHTMLFromString:(NSString *)string;

- (instancetype)htmlFromString:(NSString *)string;

+ (void)hideTextInsets:(NSArray<UITextView *> *)textViews;

- (instancetype)textAlign:(enum NSTextAlignment)alignment;

- (instancetype)font:(UIFont *)font;

- (instancetype)textColor:(UIColor *)textColor;

- (instancetype)setFontSize:(CGFloat)size;

- (instancetype)fontSize:(CGFloat)size;

- (instancetype)setFontStyle:(UIFontTextStyle)style;

- (instancetype)fontStyle:(UIFontTextStyle)style;
@end