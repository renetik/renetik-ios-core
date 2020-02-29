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
#import "NSArray+CSExtension.h"
#import "UIView+CSDimension.h"
#import "UIView+CSPosition.h"
#import "NSObject+CSExtension.h"

static void *csViewContentPropertyKey = &csViewContentPropertyKey;

@implementation UIView (CSContainer)

//+ (instancetype)withContentView {
//    let instance = self.construct;
//    [instance content:UIView.construct].matchParent;
//    return instance;
//}

//+ (instancetype)wrap:(UIView *)view {
//    UIView *container = [self withFrame:view.frame];
//    let center = view.center;
//    let superview = view.superview;
//    let autoSize = view.autoresizingMask;
//    [container content:view].matchParent;
//    [[superview add:container] center:center].autoresizingMask = autoSize;
//    container.backgroundColor = view.backgroundColor;
//    view.backgroundColor = UIColor.clearColor;
//    return container;
//}

//+ (instancetype)withContent:(UIView*)view {
//    UIView*container = [self withFrame:view.frame];
//    [container content:view];
//    return container;
//}

//+ (instancetype)wrap:(UIView *)view withPadding:(NSInteger)padding {
//    UIView *container = [self withSize:view.width + padding * 2 :view.height + padding * 2];
//    let center = view.center;
//    let superview = view.superview;
//    let autoSize = view.autoresizingMask;
//    [[container content:view] matchParentWithMargin:padding];
//    [[superview add:container] center:center].autoresizingMask = autoSize;
//    container.backgroundColor = view.backgroundColor;
//    view.backgroundColor = UIColor.clearColor;
//    return container;
//}

- (UIView *)content:(UIView *)view {
    self.content = view;
    return view;
}

- (void)setContent:(UIView *)view {
    if (self.content) [self.content removeFromSuperview];
    [self setWeakObject:csViewContentPropertyKey :view];
    [self add:view];
}

- (UIView *)content {
    return [self getObject:csViewContentPropertyKey];
}

- (UIView *)findLastSubviewOfClass:(Class)pClass {
    for (NSInteger i = self.subviews.count - 1; i >= 0; i--) {
        UIView *subView = self.subviews[(NSUInteger) i];
        if ([subView isMemberOfClass:pClass]) return subView;
    }
    return nil;
}

- (instancetype)clearSubviews {
    for (UIView *view in self.subviews) [view removeFromSuperview];
    return self;
}

- (BOOL)isEmpty {
    return self.subviews.count == 0;
}

- (UIView *)add:(UIView *)view {
    [self addSubview:view];
    return view;
}

- (instancetype)addViews:(NSArray<UIView *> *)views {
    for (UIView *view in views) [self addSubview:view];
    return self;
}

- (UIView *)addView:(UIView *)view :(NSInteger)index {
    [self insertSubview:view atIndex:index];
    return view;
}

- (UIView *)setView:(UIView *)view :(NSInteger)index {
    if ([self.subviews at:index]) [[self.subviews at:index] removeFromSuperview];
    [self insertSubview:view atIndex:index];
    return view;
}

//- (UIView *)horizontalLayoutAdd:(UIView *)view {
//    return [self horizontalLayoutAdd:view margin:0];
//}

//- (UIView *)horizontalLayoutAdd:(UIView *)view margin:(NSInteger)margin columns:(NSInteger)columns {
//    view.width = (self.width - margin * (columns + 1)) / columns;
//    return [self horizontalLayoutAdd:view margin:margin];
//}

//- (UIView *)horizontalLayoutAdd:(UIView *)view margin:(NSInteger)margin {
//    UIView *lastSubview = self.subviews.last;
//    if (lastSubview) {
//        if (lastSubview.right + margin + view.width + margin <= self.width) {
//            [view fromLeft:lastSubview.right + margin];
//            [view fromTop:lastSubview.top];
//        } else {
//            [view fromLeft:margin];
//            [view fromTop:lastSubview.bottom + margin];
//        }
//    } else {
//        [view fromLeft:margin];
//        [view fromTop:margin];
//    }
//    return [self add:view];
//}

//- (UIView *)horizontalLineAdd:(UIView *)view {
//    return [self horizontalLineAdd:view margin:0];
//}

//- (UIView *)horizontalLineAdd:(UIView *)view margin:(NSInteger)margin {
//    UIView *lastSubview = self.subviews.last;
//    [view fromLeft:lastSubview ? lastSubview.right : 0];
//    if (view.left != 0) view.left += margin;
//    return [self add:view];
//}

//- (UIView *)horizontalReverseLayoutAdd:(UIView *)view {
//    UIView *lastSubview = self.subviews.last;
//    if (lastSubview) {
//        if (lastSubview.left - view.width >= 0) {
//            [view fromBottom:lastSubview.bottom];
//            [view fromRight:lastSubview.left];
//        } else {
//            [view fromBottom:lastSubview.top];
//            [view fromRight:self.width];
//        }
//    } else {
//        [view fromBottom:self.height];
//        [view fromRight:self.width];
//    }
//    return [self add:view];
//}

//- (UIView *)verticalLayoutAdd:(UIView *)view {
//    return [self verticalLayoutAdd:view margin:0];
//}

//- (UIView *)verticalLayoutAdd:(UIView *)view margin:(NSInteger)margin {
//    return [self verticalLayoutUpdate:[self add:view] margin:margin];
//}

//- (UIView *)verticalLayoutUpdate:(UIView *)view margin:(NSInteger)margin {
//    UIView *previousSubview = [self.subviews getPreviousOf:view];
//    if (previousSubview) {
//        if (previousSubview.bottom + view.height <= self.height) {
//            [view fromLeft:previousSubview.left + margin];
//            [view fromTop:previousSubview.bottom + margin];
//        } else {
//            [view fromLeft:previousSubview.right + margin];
//            [view fromTop:margin];
//        }
//    } else {
//        [view fromLeft:margin];
//        [view fromTop:margin];
//    }
//    return view;
//}

//- (UIView *)verticalLineAdd:(UIView *)view {
//    return [self verticalLineAdd:view margin:0];
//}
//
//- (UIView *)verticalLineAdd:(UIView *)view margin:(NSInteger)margin {
//    return [self verticalLineUpdate:[self add:view] margin:margin];
//}
//
//- (UIView *)verticalLineUpdate:(UIView *)view margin:(NSInteger)margin {
//    UIView *previousSubview = [self.subviews getPreviousOf:view];
//    [view fromTop:previousSubview ? previousSubview.bottom : 0];
//    if (view.top != 0) view.top += margin;
//    return view;
//}

//- (UIView *)verticalLineAtPosition:(NSInteger)position
//                              view:(UIView *)view margin:(NSInteger)margin {
//    UIView *lastSubview = [self.subviews at:position - 1];
//    [view fromTop:lastSubview ? lastSubview.bottom : 0];
//    if (view.top != 0) view.top += margin;
//    return view;
//}

//- (instancetype)heightByLastSubviewWithPadding:(NSInteger)margin {
//    let lastSubViewBottom = self.content ? self.content.subviews.last.bottom : self.subviews.last.bottom;
//    self.height = lastSubViewBottom > 0 ? lastSubViewBottom + margin : 0;
//    return self;
//}

@end
