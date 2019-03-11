//
// Created by Rene Dohan on 15/10/14.
// Copyright (c) 2014 Rene Dohan. All rights reserved.
//

#import "CSModalBackgroundDismissController.h"
#import "UIViewController+CSExtension.h"

@implementation CSModalBackgroundDismissController {
    UITapGestureRecognizer *_recognizer;
}

- (instancetype)construct :(CSMainController *)parent {
    [super construct :parent];
    return self;
}

- (void)viewDidAppear :(BOOL)animated {
    [super viewDidAppear :animated];
    _recognizer = [[UITapGestureRecognizer alloc] initWithTarget :self action :@selector(tapBehindDetected:)];
    [_recognizer setNumberOfTapsRequired :1];
    [_recognizer setCancelsTouchesInView :NO];
    [_recognizer setDelegate :self];
    [self.view.window addGestureRecognizer :_recognizer];
}

- (void)viewWillDisappear :(BOOL)animated {
    [super viewWillDisappear :animated];
    [self.view.window removeGestureRecognizer :_recognizer];
}

- (void)tapBehindDetected :(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {
        CGPoint location = [sender locationInView :nil];
        if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) location = CGPointMake(location.y, location.x);
        if (![self.parentMain.view pointInside :[self.parentMain.view convertPoint :location fromView :self.view.window] withEvent :nil]) {
            if (self.parentMain.view) [self dismissController];
        }
    }
}

- (BOOL)gestureRecognizerShouldBegin :(UIGestureRecognizer *)gestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer :(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer :(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer :(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch :(UITouch *)touch {
    return YES;
}

@end
