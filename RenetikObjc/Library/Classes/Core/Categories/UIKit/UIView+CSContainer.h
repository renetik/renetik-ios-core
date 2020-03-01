//
//  UIView+UIView_CSContainer.h
//  Renetik
//
//  Created by Rene Dohan on 4/11/19.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CSContainer)

- (UIView *)content:(UIView *)view;

@property(nonatomic, nullable) UIView *content;

- (nullable UIView *)findLastSubviewOfClass:(Class)pClass;

- (instancetype)clearSubviews;

- (BOOL)isEmpty;

- (instancetype)addViews:(NSArray<UIView *> *)views;

- (UIView *)addView:(UIView *)view :(NSInteger)index;

- (UIView *)setView:(UIView *)view :(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
