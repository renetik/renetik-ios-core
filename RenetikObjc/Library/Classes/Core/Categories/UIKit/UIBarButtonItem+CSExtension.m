//
// Created by Rene Dohan on 13/01/15.
// Copyright (c) 2015 creative_studio. All rights reserved.
//


#import "UIBarButtonItem+CSExtension.h"

@implementation UIBarButtonItem (CSExtension)

+ (UIBarButtonItem *)createWithImage:(UIImage *)image onClick:(void (^)(id sender))action {
    return [UIBarButtonItem.alloc bk_initWithImage:image style:UIBarButtonItemStylePlain handler:action];
}

+ (UIBarButtonItem *)createSoloTitle:(NSString *)title {
    return [UIBarButtonItem.alloc initWithTitle:title style:UIBarButtonItemStylePlain target:nil action:nil];
}

+ (UIBarButtonItem *)createWithTitle:(NSString *)title :(UIBarButtonItemStyle)style :(id)target :(SEL)action {
    return [UIBarButtonItem.alloc initWithTitle:title style:style target:target action:action];
}

+ (UIBarButtonItem *)createWithItem:(UIBarButtonSystemItem)item :(id)target :(SEL)action {
    return [UIBarButtonItem.alloc initWithBarButtonSystemItem:item target:target action:action];
}

+ (UIBarButtonItem *)createWithItem:(UIBarButtonSystemItem)item {
    return [UIBarButtonItem.alloc initWithBarButtonSystemItem:item target:nil action:nil];
}

+ (UIBarButtonItem *)createFlexSpaceItem {
    return [UIBarButtonItem.alloc initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
}

- (void)setTarget:(id)target forAction:(SEL)action {
    self.target = target;
    self.action = action;
}

+ (UIImage *)imageFromSystemBarButton:(UIBarButtonSystemItem)systemItem :(UIColor *)color {
    UIToolbar *bar = UIToolbar.new;
    UIBarButtonItem *buttonItem = [UIBarButtonItem createWithItem:systemItem];
    [bar setItems:@[buttonItem] animated:NO];
    [bar snapshotViewAfterScreenUpdates:YES];
    for (UIView *view in [(id) buttonItem view].subviews)
        if ([view isKindOfClass:UIButton.class]) {
            UIImage *image = [((UIButton *) view).imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
            [color set];
            [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
            image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            return image;
        }
    return nil;
}


@end
