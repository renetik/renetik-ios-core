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

+ (instancetype)wrap:(UIView*)view;

//+ (instancetype)withContent:(UIView*)view;

+ (instancetype)wrap:(UIView*)view withPadding:(NSInteger) padding NS_SWIFT_NAME(wrap(view:padding:));

- (UIView*)content:(UIView*)view;

@property (nonatomic, nullable) UIView*content;

- (nullable UIView*)findLastSubviewOfClass:(Class)pClass;

- (instancetype)clearSubviews;

- (BOOL)isEmpty;

- (nullable UIView*)add:(UIView*)view;

- (instancetype)addViews:(NSArray<UIView*>*)views;

- (UIView*)addView:(UIView*)view :(NSInteger) index
    NS_SWIFT_NAME(add(view:index:));

- (UIView*)setView:(UIView*)view :(NSInteger) index
    NS_SWIFT_NAME(set(view:index:));

- (UIView*)horizontalLayoutAdd:(UIView*) view
    NS_SWIFT_NAME(horizontalLayout(add:));

- (UIView*)horizontalLayoutAdd:(UIView*)view margin:(NSInteger)margin columns:(NSInteger) columns
    NS_SWIFT_NAME(horizontalLayout(add:margin:columns:));

- (UIView*)horizontalLineAdd:(UIView*) view
    NS_SWIFT_NAME(horizontalLine(add:));

- (UIView*)horizontalLineAdd:(UIView*)view margin:(NSInteger) margin
    NS_SWIFT_NAME(horizontalLine(add:margin:));

- (UIView*)horizontalReverseLayoutAdd:(UIView*) view
    NS_SWIFT_NAME(horizontalReverseLayout(add:));

- (UIView*)verticalLayoutAdd:(UIView*) view
    NS_SWIFT_NAME(verticalLayout(add:));

- (UIView*)verticalLayoutAdd:(UIView*)view margin:(NSInteger) margin
    NS_SWIFT_NAME(verticalLayout(add:margin:));

- (UIView*)verticalLineAdd:(UIView*) view
    NS_SWIFT_NAME(verticalLine(add:));

- (UIView*)verticalLineAdd:(UIView*)view margin:(NSInteger) margin
    NS_SWIFT_NAME(verticalLine(add:margin:));

- (UIView*)verticalLineAtPosition:(NSInteger)position
    view:(UIView*)view margin:(NSInteger) margin
    NS_SWIFT_NAME(verticalLine(position:view:margin:));

- (instancetype)heightByLastSubviewWithPadding:(NSInteger) padding
    NS_SWIFT_NAME(heightByLastSubview(padding:));

@end

NS_ASSUME_NONNULL_END
