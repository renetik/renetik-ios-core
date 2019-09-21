//
//  Created by Rene Dohan on 4/29/12.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (CSExtension)

@property(readonly, nullable) UIViewController *previous;

@property(readonly, nullable) UIViewController *last;

@property(readonly, nullable) UIViewController *beforePrevious;

@property(readonly, nullable) UIViewController *root;

- (void)pushAsRoot:(UIViewController *)newRoot;

- (UIViewController *)push:(UIViewController *)controller;

- (UIViewController *)pushFromTop:(UIViewController *)controller;

- (UIViewController *)pushFromBottom:(UIViewController *)controller;

- (UIViewController *)pushFromLeft:(UIViewController *)controller;

- (UIViewController *)pushFromRight:(UIViewController *)controller;

- (NSArray *)popToViewController:(UIViewController *)viewController;

- (void)popToViewControllerOfClass:(Class)viewControllerClass;

- (void)popToViewControllerBefore:(Class)pClass;

- (void)pushAsSingle:(UIViewController *)pushingController;

- (void)pushViewController:(UIViewController *)controller :(NSUInteger)index1;

- (void)pushViewControllerAsSecondOfItsKind:(UIViewController *)controller;

- (UIViewController *)popViewController;

- (void)pushViewControllerAsFirstOfItsKind:(UIViewController *)newcontroller;

- (void)pushViewController:(UIViewController *)newController after:(Class)afterControllerClass;

- (void)replaceLast:(UIViewController *)controller;

- (void)pushInsteadOfLast:(UIViewController *)controller;

- (void)push:(UIViewController *)pushingController keepLast:(NSInteger)count;

- (BOOL)contains:(Class)controllerClass;
@end

NS_ASSUME_NONNULL_END
