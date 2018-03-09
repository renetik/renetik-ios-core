//
// Created by Rene Dohan on 22/10/14.
// Copyright (c) 2014 Rene Dohan. All rights reserved.
//

#import "UIPopoverController+CSExtension.h"

@implementation UIPopoverController (CSExtension)

+ (UIPopoverController *)createFromContentView:(id <UIPopoverControllerDelegate>)delegate :(UIView *)view {
    UIViewController *viewController = UIViewController.new;
    viewController.view = view;
    viewController.preferredContentSize = view.frame.size;
    UIPopoverController *controller = [UIPopoverController.alloc initWithContentViewController:viewController];
    controller.backgroundColor = view.backgroundColor;
    controller.delegate = delegate;
    return controller;

}
@end