//
//  Created by Rene Dohan on 4/29/12.
//


@import UIKit;


@interface UINavigationController (CSExtension)

- (void)pushAsRoot:(UIViewController *)newRoot;

- (UIViewController *)rootController;

- (UIViewController *)push:(UIViewController *)controller;

- (NSArray *)popToViewController:(UIViewController *)viewController;

- (void)popToViewControllerOfClass:(Class)viewControllerClass;

- (void)popToViewControllerBefore:(Class)pClass;

- (void)pushAsSingle:(UIViewController *)pushingController;

- (void)pushViewController:(UIViewController *)controller :(NSUInteger)index1;

- (void)pushViewControllerAsSecondOfItsKind:(UIViewController *)controller;

- (UIViewController *)popViewController;

- (UIViewController *)beforePrevious;

- (void)pushViewControllerAsFirstOfItsKind:(UIViewController *)newcontroller;

- (void)pushViewController:(UIViewController *)newController after:(Class)afterControllerClass;

- (UIViewController *)lastController;

- (void)replaceLast:(UIViewController *)controller;

- (void)pushInsteadOfLast:(UIViewController *)controller;

- (UIViewController *)previous;

- (UIViewController *)last;

- (BOOL)contains:(Class)controllerClass;
@end
