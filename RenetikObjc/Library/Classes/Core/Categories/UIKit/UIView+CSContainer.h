//
//  UIView+UIView_CSContainer.h
//  Renetik
//
//  Created by Rene Dohan on 4/11/19.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CSContainer)

+ (instancetype)withContentView;

+ (instancetype)wrap:(UIView *)view;

+ (instancetype)wrap:(UIView *)view withPadding:(NSInteger)padding NS_SWIFT_NAME(wrap(view:padding:));

- (UIView *)content:(UIView *)view;

@property(nonatomic, nullable) UIView *content;

- (nullable UIView *)findLastSubviewOfClass:(Class)pClass;

- (instancetype)clearSubviews;

- (BOOL)isEmpty;

- (nullable UIView *)add:(UIView *)view;

- (instancetype)addViews:(NSArray<UIView *> *)views;

- (UIView *)addView:(UIView *)view :(NSInteger)index
NS_SWIFT_NAME(add(view:index:));

- (UIView *)setView:(UIView *)view :(NSInteger)index
NS_SWIFT_NAME(set(view:index:));

- (UIView *)horizontalLayoutAdd:(UIView *)view;

- (UIView *)horizontalLayoutAdd:(UIView *)view margin:(NSInteger)margin columns:(NSInteger)columns;

- (UIView *)horizontalLineAdd:(UIView *)view;

- (UIView *)horizontalLineAdd:(UIView *)view margin:(NSInteger)margin;

- (UIView *)horizontalReverseLayoutAdd:(UIView *)view
NS_SWIFT_NAME(horizontalReverseLayout(add:));

- (UIView *)verticalLayoutAdd:(UIView *)view;

- (UIView *)verticalLayoutAdd:(UIView *)view margin:(NSInteger)margin;

- (UIView *)verticalLayoutUpdate:(UIView *)view margin:(NSInteger)margin;

- (UIView *)verticalLineAdd:(UIView *)view
NS_SWIFT_NAME(verticalLine(add:));

- (UIView *)verticalLineAdd:(UIView *)view margin:(NSInteger)margin
NS_SWIFT_NAME(verticalLine(add:margin:));

- (UIView *)verticalLineUpdate:(UIView *)view margin:(NSInteger)margin
NS_SWIFT_NAME(verticalLine(update:margin:));

- (UIView *)verticalLineAtPosition:(NSInteger)position
                              view:(UIView *)view margin:(NSInteger)margin
NS_SWIFT_NAME(verticalLine(position:view:margin:));

- (instancetype)heightByLastSubviewWithPadding:(NSInteger)padding
NS_SWIFT_NAME(heightByLastSubview(padding:));

@end

NS_ASSUME_NONNULL_END
