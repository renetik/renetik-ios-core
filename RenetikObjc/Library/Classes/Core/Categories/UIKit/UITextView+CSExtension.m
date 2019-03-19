#import "UITextView+CSExtension.h"
#import "CSLang.h"
#import "NSString+CSExtension.h"
#import "NSObject+CSExtension.h"
#import "UIView+CSExtension.h"
#import "UIView+CSDimension.h"

@implementation UITextView (CSExtension)

- (instancetype)setHTMLFromString :(NSString *)string {
    string = [string add :stringf(
                  @"<style>body{font-family: '%@'; font-size:%fpx;}</style>", self.font.fontName, self.font.pointSize)];
    self.attributedText = [NSAttributedString.alloc initWithData :[string dataUsingEncoding :NSUnicodeStringEncoding] options :@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding) }
                                              documentAttributes      :nil error :nil];
    return self;
}

- (instancetype)htmlFromString :(NSString *)string {
    [self setHTMLFromString :string];
    return self;
}

+ (void)hideTextInsets :(NSArray<UITextView *> *)textViews {
    for (UITextView *view in textViews) view.textContainerInset = UIEdgeInsetsZero;
}

- (instancetype)asLabel {
    self.textContainerInset = UIEdgeInsetsZero;
    self.contentInset = UIEdgeInsetsZero;
    self.editable = false;
    self.scrollEnabled = false;
	self.backgroundColor = UIColor.clearColor;
	self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
	self.textContainer.lineFragmentPadding = 0;
	self.layoutManager.usesFontLeading = false;
    return self;
}

- (instancetype)scrollToCursorPosition {
    doLater(0.1, ^{
        [self scrollRectToVisible :[self caretRectForPosition :self.selectedTextRange.start] animated :YES];
    });
    return self;
}

- (instancetype)dataDetector :(UIDataDetectorTypes)dataDetectorTypes {
    self.dataDetectorTypes = dataDetectorTypes;
    return self;
}

- (instancetype)text :(NSString *)text {
    self.text = text;
    return self;
}

- (instancetype)textAlign :(enum NSTextAlignment)alignment {
    self.textAlignment = alignment;
    return self;
}

- (instancetype)font :(UIFont *)font {
    self.font = font;
    return self;
}

- (instancetype)textColor :(UIColor *)textColor {
    self.textColor = textColor;
    return self;
}

- (instancetype)setFontSize :(CGFloat)size {
    self.font = [self.font fontWithSize :size];
    return self;
}

- (instancetype)fontSize :(CGFloat)size {
    self.font = [self.font fontWithSize :size];
    return self;
}

- (instancetype)setFontStyle :(UIFontTextStyle)style {
    self.font = [UIFont preferredFontForTextStyle :style];
    return self;
}

- (instancetype)fontStyle :(UIFontTextStyle)style {
    self.font = [UIFont preferredFontForTextStyle :style];
    return self;
}

- (instancetype)sizeHeightToLines :(NSInteger)numberOfLines {
    let currentWidth = self.width;
    let currentText = self.text;
    self.text = @"line";
    for (int i = 0; i < numberOfLines - 1; i++) self.text = [self.text add :@"\n line"];
    [self sizeToFit];
    self.text = currentText;
    self.width = currentWidth;
    return self;
}

@end
