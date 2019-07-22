//
// Created by Rene Dohan on 19/02/18.
// Copyright (c) 2018 renetik_software. All rights reserved.
//

#import "UIScreen+CSExtension.h"
#import "CSLang.h"

@implementation UIScreen (CSExtension)

+ (BOOL)isPortrait {
	let window = UIApplication.sharedApplication.delegate.window;
	if(window.rootViewController) {
		let orientation =
		window.rootViewController.interfaceOrientation;
		return UIInterfaceOrientationIsPortrait(orientation);
	} else {
		let orientation =
		UIApplication.sharedApplication.statusBarOrientation;
		return UIInterfaceOrientationIsPortrait(orientation);
	}
}

+ (BOOL)isLandscape {
	return !self.isPortrait;
}

+ (CGFloat)height {
	return UIScreen.mainScreen.bounds.size.height;
}

+ (CGFloat)width {
	return UIScreen.mainScreen.bounds.size.width;
}
@end
