//
//  Created by Rene Dohan on 10/26/12.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, CSForcedOrientation) {
    CSForcedOrientationNone,
    CSForcedOrientationPortrait,
    CSForcedOrientationLandscape,
};

@interface CSNavigationController : UINavigationController

@property(nonatomic, readonly, nullable) UIViewController *lastPopped;

@property(nonatomic, strong, readonly) CSNavigationController *instance;

- (void)forceOrientation:(CSForcedOrientation)orientation;

- (void)cancelForcedOrientation;

@end

NS_ASSUME_NONNULL_END
