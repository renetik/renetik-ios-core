#import "UITextView+CSExtension.h"
#import "CSLang.h"

@implementation UITextView (CSExtension)

- (void)setHtmlWithViewFontSize:(NSString *)string {
    string = [string stringByAppendingString:[NSString stringWithFormat:@"<style>body{font-family: '%@'; font-size:%fpx;}</style>",
                                                                        self.font.fontName,
                                                                        self.font.pointSize]];
    self.attributedText = [NSAttributedString.alloc initWithData:[string dataUsingEncoding:NSUnicodeStringEncoding]
                                                         options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                                                                 NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)}
                                              documentAttributes:nil error:nil];
}

+ (void)hideTextInsets:(NSArray<UITextView *> *)textViews {
    for (UITextView *view in textViews) view.textContainerInset = UIEdgeInsetsZero;
}

- (instancetype)asLabel {
    self.textContainerInset = UIEdgeInsetsZero;
    self.contentInset = UIEdgeInsetsZero;
    self.editable = NO;
    self.scrollEnabled = NO;
    return self;
}

- (instancetype)scrollToCursorPosition {
    doLater(0.1, ^{
        [self scrollRectToVisible:[self caretRectForPosition:self.selectedTextRange.start] animated:YES];
    });
    return self;
}

@end