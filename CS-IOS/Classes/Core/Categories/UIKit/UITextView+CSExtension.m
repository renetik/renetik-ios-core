#import "UITextView+CSExtension.h"

@implementation UITextView (CSExtension)

- (void)setHTMLWithViewFontSize:(NSString *)string {
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

+ (void)asLabel:(NSArray<UITextView *> *)textViews {
    for (UITextView *view in textViews){
        view.textContainerInset = UIEdgeInsetsZero;
        view.editable = NO;
        view.scrollEnabled = NO;
    }
}

@end