//
// Created by Rene Dohan on 02/12/14.
// Copyright (c) 2014 creative_studio. All rights reserved.
//

#import "UILabel+CSExtension.h"
#import "CSLang.h"
#import "UIView+CSDimension.h"
#import "NSString+CSExtension.h"
#import "UIView+CSExtension.h"

@implementation UILabel (CSExtension)

//- (instancetype)construct {
//    super.construct;
//    self.lineBreakMode = NSLineBreakByTruncatingTail;
////	self.backgroundColor = UIColor.clearColor;
//    return self;
//}

//- (void)setFontSize:(CGFloat)size {
//    self.font = [self.font fontWithSize:size];
//}
//
//- (CGFloat)fontSize {
//    return self.font.pointSize;
//}
//
//- (instancetype)fontSize:(CGFloat)size {
//    self.fontSize = size;
//    return self;
//}
//
//- (void)setFontStyle:(UIFontTextStyle)style {
//    self.font = [UIFont preferredFontForTextStyle:style];
//}
//
//- (UIFontTextStyle)fontStyle {
//    return [self.font.fontDescriptor objectForKey:UIFontDescriptorTextStyleAttribute];
//}
//
//- (instancetype)fontStyle:(UIFontTextStyle)style {
//    self.fontStyle = style;
//    return self;
//}
//
//- (instancetype)font:(UIFont *)font {
//    self.font = font;
//    return self;
//}
//
//- (instancetype)textColor:(UIColor *)textColor {
//    self.textColor = textColor;
//    return self;
//}

//- (instancetype)setHTMLFromString:(NSString *)string {
//    string = [string add:stringf(@"<style>body{font-family: '%@'; font-size:%fpx;}</style>",
//            self.font.fontName, self.font.pointSize)];
//    self.attributedText =
//            [NSAttributedString.alloc initWithData:[string dataUsingEncoding:NSUnicodeStringEncoding]
//                                           options:@{
//                                                   NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
//                                                   NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)
//                                           } documentAttributes:nil error:nil];
//    return self;
//}

//- (instancetype)hideIfEmpty {
//    [self setVisible:self.text.trim.set];
//    return self;
//}
//
//- (instancetype)heightToFit { // TODO: move to swift and rename appropriately
//    self.numberOfLines = 0;
//    super.heightToFit;
//    return self;
//}

//- (instancetype)sizeFit:(NSString *)value { // TODO: move to swift and rename appropriately
//    self.numberOfLines = 0;
//    let current = self.text;
//    return [[self text:value].resizeToFit text:current];
//}
//
//- (instancetype)sizeHeightToFit:(NSString *)value { // TODO: move to swift and rename appropriately
//    self.numberOfLines = 0;
//    let current = self.text;
//    self.text = value;
//    self.height = self.calculateHeightToFitWidth;
//    self.text = current;
//    return self;
//}

- (instancetype)heightToLines:(NSInteger)numberOfLines { // TODO: move to swift and rename appropriately
//    NSAssert(self.width > 0, @"Width has to be set to calculate height");
    let currentWidth = self.width;
    let currentText = self.text;
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
    self.width = currentWidth;
    return self;
}

//- (instancetype)text:(NSString *)string {
//    self.text = string;
//    return self;
//}
//
//- (instancetype)textAlign:(enum NSTextAlignment)alignment {
//    self.textAlignment = alignment;
//    return self;
//}
//
//- (instancetype)lineBreak:(NSLineBreakMode)mode {
//    self.lineBreakMode = mode;
//    return self;
//}

@end
