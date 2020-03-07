//
//  UIView+CSContainer.m
//  Renetik
//
//  Created by Rene Dohan on 4/11/19.
//

//@import BlocksKit;
//
//#import "UIView+CSContainer.h"
//#import "UIView+CSExtension.h"
//#import "CSLang.h"
//#import "NSArray+CSExtension.h"
//#import "UIView+CSDimension.h"
//#import "UIView+CSPosition.h"
//#import "NSObject+CSExtension.h"
//
//static void *csViewContentPropertyKey = &csViewContentPropertyKey;
//
//@implementation UIView (CSContainer)

//- (UIView *)content:(UIView *)view {
//    self.content = view;
//    return view;
//}
//
//- (void)setContent:(UIView *)view {
//    if (self.content) [self.content removeFromSuperview];
//    [self setWeakObject:csViewContentPropertyKey :view];
//    [self add:view];
//}
//
//- (UIView *)content {
//    return [self getObject:csViewContentPropertyKey];
//}

//- (UIView *)findLastSubviewOfClass:(Class)pClass {
//    for (NSInteger i = self.subviews.count - 1; i >= 0; i--) {
//        UIView *subView = self.subviews[(NSUInteger) i];
//        if ([subView isMemberOfClass:pClass]) return subView;
//    }
//    return nil;
//}

//- (instancetype)clearSubviews {
//    for (UIView *view in self.subviews) [view removeFromSuperview];
//    return self;
//}

//- (BOOL)isEmpty {
//    return self.subviews.count == 0;
//}

//- (UIView *)add:(UIView *)view {
//    [self addSubview:view];
//    return view;
//}

//- (instancetype)addViews:(NSArray<UIView *> *)views {
//    for (UIView *view in views) [self addSubview:view];
//    return self;
//}
//
//- (UIView *)addView:(UIView *)view :(NSInteger)index {
//    [self insertSubview:view atIndex:index];
//    return view;
//}
//
//- (UIView *)setView:(UIView *)view :(NSInteger)index {
//    if ([self.subviews at:index]) [[self.subviews at:index] removeFromSuperview];
//    [self insertSubview:view atIndex:index];
//    return view;
//}
//@end
