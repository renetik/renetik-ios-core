#import "UITextView+CSExtension.h"
#import "CSLang.h"
#import "NSString+CSExtension.h"

@implementation UITextView (CSExtension)

- (instancetype)setHTMLFromString:(NSString *)string {
    string = [string add:stringf(
            @"<style>body{font-family: '%@'; font-size:%fpx;}</style>", self.font.fontName, self.font.pointSize)];
    self.attributedText = [NSAttributedString.alloc initWithData:[string dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)}
                                              documentAttributes:nil error:nil];
    return self;
}

- (instancetype)htmlByString:(NSString *)string {
    [self setHTMLFromString:string];
    return self;
}

- (instancetype)scrollToCursorPosition {
    doLater(0.1, ^{
        [self scrollRectToVisible:[self caretRectForPosition:self.selectedTextRange.start] animated:YES];
    });
    return self;
}

@end
