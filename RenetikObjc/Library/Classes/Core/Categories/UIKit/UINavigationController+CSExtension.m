//
//  Created by Rene Dohan on 4/29/12.
//
#import "CSLang.h"
#import "NSArray+CSExtension.h"
#import "NSMutableArray+CSExtension.h"
#import "UIViewController+CSExtension.h"
#import "UINavigationController+CSExtension.h"

@implementation UINavigationController (CSExtension)

- (UIViewController *)popViewController {
    return [self popViewControllerAnimated :YES];
}

- (UIViewController *)last {
    return self.viewControllers.lastObject;
}

- (UIViewController *)beforePrevious {
    return [self.viewControllers at :self.viewControllers.lastIndex - 2];
}

- (UIViewController *)previous {
    return [self.viewControllers at :self.viewControllers.lastIndex - 1];
}

- (UIViewController *)root {
	return self.viewControllers.first;
}

- (void)pushAsRoot :(UIViewController *)newRoot {
    [self setViewControllers :@[newRoot] animated :YES];
}

- (UIViewController *)push :(UIViewController *)controller {
    [self pushViewController :controller animated :YES];
    return controller;
}

- (UIViewController *)pushFromTop :(UIViewController *)controller {
    CATransition *transition = CATransition.animation;
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName :kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionMoveIn; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    transition.subtype = kCATransitionFromBottom; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    [self.view.layer addAnimation :transition forKey :nil];
    [self pushViewController :controller animated :NO];
    return controller;
}

- (UIViewController *)pushFromBottom :(UIViewController *)controller {
    CATransition *transition = CATransition.animation;
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName :kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionMoveIn; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    transition.subtype = kCATransitionFromTop; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    [self.view.layer addAnimation :transition forKey :nil];
    [self pushViewController :controller animated :NO];
    return controller;
}

- (NSArray *)popToViewController :(UIViewController *)viewController {
    return [self popToViewController :viewController animated :YES];
}

- (void)popToViewControllerOfClass :(Class)viewControllerClass {
    for (UIViewController *controller in self.viewControllers)
        if ([controller isKindOfClass :viewControllerClass]) {
            [self popToViewController :controller];
            return;
        }
    NSLog(@"popToViewControllerOfClass not found controller of class %@", viewControllerClass.description);
}

- (void)popToViewControllerBefore :(Class)viewControllerClass {
    for (uint i = 1; i < self.viewControllers.count; i++) {
        UIViewController *controller = self.viewControllers[i];
        if ([controller isKindOfClass :viewControllerClass]) {
            [self popToViewController :self.viewControllers[i - 1]];
            return;
        }
    }
    NSLog(@"popToViewControllerBefore not found controller of class %@", viewControllerClass.description);
}

- (void)pushAsSingle :(UIViewController *)pushingController {
    NSMutableArray *toRemove = NSMutableArray.new;

    for (UIViewController *controller in self.viewControllers)
        if ([controller isKindOfClass :pushingController.class]) [toRemove put :controller];

    NSMutableArray *viewControllers = [NSMutableArray arrayWithArray :self.viewControllers];
    [viewControllers removeObjectsInArray :toRemove];
    [viewControllers put :pushingController];
    [self setViewControllers :viewControllers animated :YES];
}

- (void)pushViewController :(UIViewController *)controller :(NSUInteger)index {
    NSArray *range = [self.viewControllers subarrayWithRange :NSMakeRange(0, index - 1)];
    NSMutableArray *array = [NSMutableArray arrayWithArray :range];
    [array addObject :controller];
    [self setViewControllers :array animated :YES];
}

- (void)pushViewControllerAsSecondOfItsKind :(UIViewController *)newcontroller {
    uint index = 0;
    BOOL firstFoundIndex = NO;
    for (UIViewController *controller in self.viewControllers) {
        index++;
        if ([controller isKindOfClass :newcontroller.class]) {
            if (firstFoundIndex) {
                [self pushViewController :newcontroller :index];
                return;
            } else firstFoundIndex = YES;
        }
    }
    [self push :newcontroller];
}

- (void)pushViewControllerAsFirstOfItsKind :(UIViewController *)newcontroller {
    uint index = 0;
    for (UIViewController *controller in self.viewControllers) {
        index++;
        if ([controller isKindOfClass :newcontroller.class]) {
            [self pushViewController :newcontroller :index];
            return;
        }
    }
    [self push :newcontroller];
}

- (void)pushViewController :(UIViewController *)newController after :(Class)afterControllerClass {
    uint index = 0;
    for (UIViewController *controller in self.viewControllers) {
        index++;
        if ([controller isKindOfClass :afterControllerClass]) {
            [self pushViewController :newController :index + 1];
            return;
        }
    }
}

- (void)replaceLast :(UIViewController *)controller {
    NSMutableArray *viewControllers = [NSMutableArray arrayWithArray :[self viewControllers]];
    [viewControllers removeLastObject];
    [viewControllers addObject :controller];
    [self setViewControllers :viewControllers animated :YES];
}

- (void)pushInsteadOfLast :(UIViewController *)controller {
    NSMutableArray *viewControllersToRemove = NSMutableArray.new;
    for (NSInteger index = self.viewControllers.count - 1; index >= 0; index--) {
        UIViewController *pushed = [self.viewControllers at :(NSUInteger)index];
        [viewControllersToRemove put :pushed];
        if ([pushed isKindOfClass :controller.class]) break;
    }
    NSMutableArray *viewControllers = [NSMutableArray arrayWithArray :[self viewControllers]];
    [viewControllers removeObjectsInArray :viewControllersToRemove];
    [viewControllers put :controller];
    [self setViewControllers :viewControllers animated :YES];
}

- (BOOL)contains :(Class)controllerClass {
    for (UIViewController *controller in self.viewControllers)
        if ([controller isKindOfClass :controllerClass]) return YES;
    return NO;
}

@end
