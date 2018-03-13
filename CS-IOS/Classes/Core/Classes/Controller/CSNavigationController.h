//
//  Created by Rene Dohan on 10/26/12.
//


#import <UIKit/UIKit.h>

@interface CSNavigationController : UINavigationController

@property(readonly) UIViewController *lastPopped;

@property(nonatomic, strong, readonly) CSNavigationController *instance;

@end
