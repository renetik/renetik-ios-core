//
// Created by Rene Dohan on 02/12/14.
// Copyright (c) 2014 creative_studio. All rights reserved.
//

#import "UILabel+CSExtension.h"
#import "UIView+CSDimension.h"


@implementation UILabel (CSExtension)

- (instancetype)setFontSize:(CGFloat)size {
    self.font = [self.font fontWithSize:size];
    return self;
}

- (instancetype)fontSize:(CGFloat)size {
    self.font = [self.font fontWithSize:size];
    return self;
}

- (void)setFontStyle:(UIFontTextStyle)style {
    self.font = [UIFont preferredFontForTextStyle:style];
}

- (instancetype)fontStyle:(UIFontTextStyle)style {
    self.font = [UIFont preferredFontForTextStyle:style];
    return self;
}

- (instancetype)font:(UIFont *)font {
    self.font = font;
    return self;
}

- (instancetype)textColor:(UIColor *)textColor {
    self.textColor = textColor;
    return self;
}

- (instancetype)setHTMLFromString:(NSString *)string {
    string = [string add:stringf(
            @"<style>body{font-family: '%@'; font-size:%fpx;}</style>",self.font.fontName, self.font.pointSize)];
    self.attributedText = [NSAttributedString.alloc initWithData:[string dataUsingEncoding:NSUnicodeStringEncoding]
                                                         options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                                                                 NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)}
                                              documentAttributes:nil error:nil];
    return self;
}


- (instancetype)hideIfEmpty {
    [self setVisible:[NSString set:self.text]];
    return self;
}

- (instancetype)sizeToLines:(int)numberOfLines {
    var currentText = self.text;
    self.text = @"cjksjkljaskljfklsaj fjas klfjaslk jfklaj fklaj fkljs aklfj klasj"
                " fljsahflasljh sdiaf uiau fiahfiohe iof aeuhfkuaedfiuaehfueahkufheuafuaehfoiuyeaoif "
                "aeil fklaehjlfhaekjfhgkaegfjgeauklfeakuhfkluaehkfheaklufhkljaehfk hleauk "
                "fhlkuaehfjkaekfgeakfgkalehfkjahekjlfhkjelhqfkheukfglkgfalkjgfkagefjklgaekfgeajk"
                " fljsahflasljh sdiaf uiau fiahfiohe iof aeuhfkuaedfiuaehfueahkufheuafuaehfoiuyeaoif "
                "aeil fklaehjlfhaekjfhgkaegfjgeauklfeakuhfkluaehkfheaklufhkljaehfk hleauk "
                "fhlkuaehfjkaekfgeakfgkalehfkjahekjlfhkjelhqfkheukfglkgfalkjgfkagefjklgaekfgeajk"
                " fljsahflasljh sdiaf uiau fiahfiohe iof aeuhfkuaedfiuaehfueahkufheuafuaehfoiuyeaoif "
                "aeil fklaehjlfhaekjfhgkaegfjgeauklfeakuhfkluaehkfheaklufhkljaehfk hleauk "
                "fhlkuaehfjkaekfgeakfgkalehfkjahekjlfhkjelhqfkheukfglkgfalkjgfkagefjklgaekfgeajk"
                " fljsahflasljh sdiaf uiau fiahfiohe iof aeuhfkuaedfiuaehfueahkufheuafuaehfoiuyeaoif "
                "aeil fklaehjlfhaekjfhgkaegfjgeauklfeakuhfkluaehkfheaklufhkljaehfk hleauk "
                "fhlkuaehfjkaekfgeakfgkalehfkjahekjlfhkjelhqfkheukfglkgfalkjgfkagefjklgaekfgeajk";
    self.numberOfLines = numberOfLines;
    [self sizeToFit];
    self.text = currentText;
    return self;
}


- (instancetype)sizeFit:(NSString *)value {
    var current = self.text;
    return [[self text:value].sizeFit text:current];
}

- (instancetype)text:(NSString *)string {
    self.text = string;
    return self;
}

- (instancetype)textAlign:(enum NSTextAlignment)alignment {
    self.textAlignment = alignment;
    return self;
}
@end
