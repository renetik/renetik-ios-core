//
//  UIView+UIView_CSContainer.h
//  Renetik
//
//  Created by Rene Dohan on 4/11/19.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CSContainer)

//+ (instancetype)withContentView;

//+ (instancetype)wrap:(UIView *)view;

//+ (instancetype)wrap:(UIView *)view withPadding:(NSInteger)padding NS_SWIFT_NAME(wrap(view:padding:));

- (UIView *)content:(UIView *)view;

@property(nonatomic, nullable) UIView *content;

- (nullable UIView *)findLastSubviewOfClass:(Class)pClass;

- (instancetype)clearSubviews;

- (BOOL)isEmpty;

//- (UIView *)add:(UIView *)view;

- (instancetype)addViews:(NSArray<UIView *> *)views;

- (UIView *)addView:(UIView *)view :(NSInteger)index;

- (UIView *)setView:(UIView *)view :(NSInteger)index;

//- (UIView *)horizontalLayoutAdd:(UIView *)view;

//- (UIView *)horizontalLayoutAdd:(UIView *)view margin:(NSInteger)margin columns:(NSInteger)columns;

//- (UIView *)horizontalLineAdd:(UIView *)view;

//- (UIView *)horizontalLineAdd:(UIView *)view margin:(NSInteger)margin;

//- (UIView *)horizontalReverseLayoutAdd:(UIView *)view;

//- (UIView *)verticalLayoutAdd:(UIView *)view;

//- (UIView *)verticalLayoutAdd:(UIView *)view margin:(NSInteger)margin;

//- (UIView *)verticalLayoutUpdate:(UIView *)view margin:(NSInteger)margin;

//- (UIView *)verticalLineAdd:(UIView *)view;
//
//- (UIView *)verticalLineAdd:(UIView *)view margin:(NSInteger)margin;
//
//- (UIView *)verticalLineUpdate:(UIView *)view margin:(NSInteger)margin;

//- (UIView *)verticalLineAtPosition:(NSInteger)position
//                              view:(UIView *)view margin:(NSInteger)margin;

//- (instancetype)heightByLastSubviewWithPadding:(NSInteger)padding;

@end

NS_ASSUME_NONNULL_END
