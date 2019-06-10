//
// Created by Rene Dohan on 02/12/14.
// Copyright (c) 2014 creative_studio. All rights reserved.
//

#import "UILabel+CSExtension.h"

@implementation UILabel (CSExtension)

- (instancetype)setString:(NSString *)text {
    [self setText:text];
    return self;
}

- (instancetype)setFontSize:(CGFloat)size {
    self.font = [self.font fontWithSize:size];
    return self;
}

- (void)setHTMLFromString:(NSString *)string {

    string = [string stringByAppendingString:[NSString stringWithFormat:@"<style>body{font-family: '%@'; font-size:%fpx;}</style>",
                                                                        self.font.fontName,
                                                                        self.font.pointSize]];
    self.attributedText = [[NSAttributedString alloc] initWithData:[string dataUsingEncoding:NSUnicodeStringEncoding]
                                                           options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                                                                   NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)}
                                                documentAttributes:nil
                                                             error:nil];
}

@end
