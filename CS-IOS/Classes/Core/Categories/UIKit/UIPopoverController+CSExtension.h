//
// Created by Rene Dohan on 22/10/14.
// Copyright (c) 2014 Rene Dohan. All rights reserved.
//

@import UIKit;

@interface UIPopoverController (CSExtension)

+ (UIPopoverController *)createFromContentView:(id <UIPopoverControllerDelegate>)view :(UIView *)infoView;

@end
