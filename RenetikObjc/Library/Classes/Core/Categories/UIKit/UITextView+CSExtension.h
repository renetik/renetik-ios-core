//
//  Created by Rene Dohan on 1/12/13.
//
@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (CSExtension)

- (instancetype)scrollToCursorPosition;

//- (instancetype)asLabel;

- (instancetype)setHTMLFromString:(NSString *)string;

- (instancetype)htmlByString:(NSString *)string;

//+ (void)hideTextInsets:(NSArray<UITextView *> *)textViews;

- (instancetype)alignText:(enum NSTextAlignment)alignment;

- (instancetype)font:(UIFont *)font;

- (instancetype)textColor:(UIColor *)textColor;

- (instancetype)setFontSize:(CGFloat)size;

- (instancetype)fontSize:(CGFloat)size;

- (void)setFontStyle:(UIFontTextStyle)style;

- (instancetype)fontStyle:(UIFontTextStyle)style;

//- (instancetype)heightToLines:(NSInteger)numberOfLines;

@end

NS_ASSUME_NONNULL_END
