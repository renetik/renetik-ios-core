//
//  UIView+CSContainer.m
//  Renetik
//
//  Created by Rene Dohan on 4/11/19.
//

@import BlocksKit;

#import "UIView+CSContainer.h"
#import "UIView+CSExtension.h"
#import "CSLang.h"
#import "NSString+CSExtension.h"
#import "NSArray+CSExtension.h"
#import "UIColor+CSExtension.h"
#import "UIView+CSAutoResizing.h"
#import "UIView+CSDimension.h"
#import "UIView+CSPosition.h"
#import "UIView+CSLayout.h"
#import "CSCocoaLumberjack.h"
#import "NSObject+CSExtension.h"

static void*csViewContentPropertyKey = &csViewContentPropertyKey;

@implementation UIView (CSContainer)

+ (instancetype)withContentView {
    let instance = self.construct;
    [instance content:UIView.construct].matchParent;
    return instance;
}

+ (instancetype)wrap:(UIView*)view {
    UIView*container = [self withFrame:view.frame];
    let center = view.center;
    let superview = view.superview;
    let autoSize = view.autoresizingMask;
    [container content:view].matchParent;
    [[superview add:container] center:center].autoresizingMask = autoSize;
    container.backgroundColor = view.backgroundColor;
    view.backgroundColor = UIColor.clearColor;
    return container;
}

//+ (instancetype)withContent:(UIView*)view {
//    UIView*container = [self withFrame:view.frame];
//    [container content:view];
//    return container;
//}

+ (instancetype)wrap:(UIView*)view withPadding:(NSInteger)padding {
    UIView*container = [self withSize:view.width + padding * 2:view.height + padding * 2];
    let center = view.center;
    let superview = view.superview;
    let autoSize = view.autoresizingMask;
    [[container content:view] matchParentWithMargin:padding];
    [[superview add:container] center:center].autoresizingMask = autoSize;
    container.backgroundColor = view.backgroundColor;
    view.backgroundColor = UIColor.clearColor;
    return container;
}

- (UIView*)content:(UIView*)view {
    self.content = view;
    return view;
}

- (void)setContent:(UIView*)view {
    if(self.content) [self.content removeFromSuperview];
    [self setWeakObject:csViewContentPropertyKey:view];
    [self add:view];
}

- (UIView*)content {
    return [self getObject:csViewContentPropertyKey];
}

- (UIView*)findLastSubviewOfClass:(Class)pClass {
    for(NSInteger i = self.subviews.count - 1; i >= 0; i--) {
        UIView*subView = self.subviews[(NSUInteger)i];
        if([subView isMemberOfClass:pClass]) return subView;
    }
    return nil;
}

- (instancetype)clearSubviews {
    for(UIView*view in self.subviews) [view removeFromSuperview];
    return self;
}

- (UIView*)add:(UIView*)view {
    [self addSubview:view];
    return view;
}

- (instancetype)addViews:(NSArray<UIView*>*)views {
    for(UIView*view in views) [self addSubview:view];
    return self;
}

- (UIView*)addView:(UIView*)view:(NSInteger)index {
    [self insertSubview:view atIndex:index];
    return view;
}

- (UIView*)setView:(UIView*)view:(NSInteger)index {
    if([self.subviews at:index]) [[self.subviews at:index] removeFromSuperview];
    [self insertSubview:view atIndex:index];
    return view;
}

- (UIView*)horizontalLayoutAdd:(UIView*)view {
    return [self horizontalLayoutAdd:view margin:0];
}

- (UIView*)horizontalLayoutAdd:(UIView*)view margin:(NSInteger)margin columns:(NSInteger)columns {
    view.width = (self.width - margin * (columns + 1)) / columns;
    return [self horizontalLayoutAdd:view margin:margin];
}

- (UIView*)horizontalLayoutAdd:(UIView*)view margin:(NSInteger)margin {
    UIView*lastSubview = self.subviews.last;
    if(lastSubview) {
        if(lastSubview.right + margin + view.width + margin <= self.width) {
            [view left:lastSubview.right + margin];
            [view top:lastSubview.top];
        } else {
            [view left:margin];
            [view top:lastSubview.bottom + margin];
        }
    } else {
        [view left:margin];
        [view top:margin];
    }
    return [self add:view];
}

- (UIView*)horizontalLineAdd:(UIView*)view   {
    return [self horizontalLineAdd:view margin:0];
}

- (UIView*)horizontalLineAdd:(UIView*)view margin:(NSInteger)margin {
    UIView*lastSubview = self.subviews.last;
    [view left:lastSubview ? lastSubview.right : 0];
    if(view.left != 0) view.left += margin;
    return [self add:view];
}

- (UIView*)horizontalReverseLayoutAdd:(UIView*)view {
    UIView*lastSubview = self.subviews.last;
    if(lastSubview) {
        if(lastSubview.left - view.width >= 0) {
            [view fromBottom:lastSubview.bottom];
            [view fromRight:lastSubview.left];
        } else {
            [view fromBottom:lastSubview.top];
            [view fromRight:self.width];
        }
    } else {
        [view fromBottom:self.height];
        [view fromRight:self.width];
    }
    return [self add:view];
}

- (UIView*)verticalLayoutAdd:(UIView*)view {
    return [self verticalLayoutAdd:view margin:0];
}

- (UIView*)verticalLayoutAdd:(UIView*)view margin:(NSInteger)margin {
    UIView*lastSubview = self.subviews.last;
    if(lastSubview) {
        if(lastSubview.bottom + view.height <= self.height) {
            [view left:lastSubview.left + margin];
            [view top:lastSubview.bottom + margin];
        } else {
            [view left:lastSubview.right + margin];
            [view top:margin];
        }
    } else {
        [view left:margin];
        [view top:margin];
    }
    return [self add:view];
}

- (UIView*)verticalLineAdd:(UIView*)view   {
    return [self verticalLineAdd:view margin:0];
}

- (UIView*)verticalLineAdd:(UIView*)view margin:(NSInteger)margin {
    return [self add:[self verticalLineAtPosition
                      :self.subviews.lastIndex + 1 view:view margin:margin]];
}

- (UIView*)verticalLineAtPosition:(NSInteger)position
    view:(UIView*)view margin:(NSInteger)margin {
    UIView*lastSubview = [self.subviews at:position - 1];
    [view fromTop:lastSubview ? lastSubview.bottom : 0];
    if(view.top != 0) view.top += margin;
    return view;
}

- (instancetype)heightByLastSubviewWithPadding:(NSInteger)margin {
    if(self.content) [self height:self.content.subviews.last.bottom];
    else [self height:self.subviews.last.bottom];
    if(self.height) self.height += margin;
    return self;
}

@end
