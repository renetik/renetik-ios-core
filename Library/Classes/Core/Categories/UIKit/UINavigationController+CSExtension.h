//
//  Created by Rene Dohan on 4/29/12.
//


#import <Foundation/Foundation.h>
#import "CSLang.h"
#import "NSDictionary+CSExtension.h"
#import "NSArray+CSExtension.h"
#import "NSMutableArray+CSExtension.h"
#import "UIView+CSExtension.h"
#import "NSMutableDictionary+CSExtension.h"
#import "NSObject+CSExtension.h"
#import "UIViewController+CSExtension.h"
#import "UIImageView+CSExtension.h"
#import "NSIndexPath+CSExtension.h"
#import "UIDevice+CSExtension.h"
#import "UIScrollView+CSExtension.h"
#import "NSString+CSExtension.h"
#import "UIPickerView+CSExtension.h"
#import "NSLocale+CSExtension.h"
#import "NSUserDefaults+CSExtension.h"
#import "UIButton+CSExtension.h"
#import "UITableViewCell+CSExtension.h"
#import "UINavigationController+CSExtension.h"
#import "UIToolbar+CSExtension.h"
#import "UITableView+CSExtension.h"
#import "UIControl+CSExtension.h"
#import "UIImage+CSExtension.h"
#import "NSData+CSExtension.h"
#import "NSDate+CSExtensions2.h"
#import "NSDate+CSExtension.h"
#import "CSViewControllerProtocol.h"
#import "NSDateFormatter+CSExtension.h"
#import "UIColor+CSExtension.h"
#import "CALayer+CSExtension.h"
#import "UICollectionView+CSExtension.h"
#import "UINib+CSExtension.h"
#import "UIBarButtonItem+CSExtension.h"
#import "UICollectionViewCell+CSExtension.h"
#import "NSBundle+CSExtension.h"
#import "UIApplication+CSExtension.h"


@interface UINavigationController (CSExtension)

- (void)pushAsRoot:(UIViewController *)newRoot;

- (UIViewController *)rootController;

- (UIViewController *)push:(UIViewController *)controller;

- (UIViewController *)pushFromTop:(UIViewController *)controller;

- (UIViewController *)pushFromBottom:(UIViewController *)controller;

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
