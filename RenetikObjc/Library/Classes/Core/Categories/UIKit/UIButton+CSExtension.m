//
// Created by inno on 1/28/13.
//
// To change the template use AppCode | Preferences | File Templates.
//
#import "UIButton+CSExtension.h"
#import "UIControl+CSExtension.h"
#import "UIView+CSDimension.h"
#import "UIView+CSAutoResizing.h"
#import "UIView+CSLayout.h"
#import "UIView+CSExtension.h"
#import "UIView+CSContainer.h"

@implementation UIButton (CSExtension)

- (instancetype)construct {
    super.construct;
    self.imageView.aspectFit;
    return self;
}

- (void)stretchableBackgroundImageWithLeftCapWidth:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight {
    [self setBackgroundImage:[[self backgroundImageForState:UIControlStateNormal] stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight] forState:UIControlStateNormal];
    [self setBackgroundImage:[[self backgroundImageForState:UIControlStateSelected] stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight] forState:UIControlStateSelected];
    [self setBackgroundImage:[[self backgroundImageForState:UIControlStateDisabled] stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight] forState:UIControlStateDisabled];
    [self setBackgroundImage:[[self backgroundImageForState:UIControlStateHighlighted] stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight] forState:UIControlStateHighlighted];
}

- (instancetype)textColor:(UIColor *)color {
    self.titleColor = color;
    return self;
}

- (void)setTitleColor:(UIColor *)color {
    [self setTitleColor:color forState:UIControlStateNormal];
    [self setTitleColor:color forState:UIControlStateHighlighted];
    [self setTitleColor:color forState:UIControlStateDisabled];
    [self setTitleColor:color forState:UIControlStateSelected];
}

- (instancetype)title:(NSString *)title {
    [self setTitle:title forState:UIControlStateNormal];
    return self;
}

- (NSString *)title {
    return [self titleForState:UIControlStateNormal];
}

- (instancetype)image:(UIImage *)image {
    [self setImage:image forState:UIControlStateNormal];
    return self;
}

- (instancetype)aspectFit {
    [self.imageView aspectFit];
    return self;
}

- (instancetype)aspectFill {
    [self.imageView aspectFill];
    return self;
}

- (void)setImage:(UIImage *)image {
    [self image:image];
}

- (void)setBackgroundImage:(UIImage *)image {
    [self setBackgroundImage:image forState:UIControlStateNormal];
}

//+ (instancetype)addFloating:(UIView *)view :(UIImage *)image :(void (^)(UIButton *))onClick {
//    UIButton *button = [self.class construct];
//    [view add:[button.resizeToFit onTouchUp:^(UIView *view) {
//        onClick((UIButton *) view);
//    }]];
//    [button image:image];
//    return [[button fromRight:25] fromBottom:25].flexibleLeftTop;
//}

@end
