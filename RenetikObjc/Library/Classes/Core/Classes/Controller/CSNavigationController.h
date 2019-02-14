//
//  Created by Rene Dohan on 10/26/12.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN
@interface CSNavigationController : UINavigationController

@property(readonly, nullable) UIViewController *lastPopped;

@property(nonatomic, strong, readonly) CSNavigationController *instance;

@end
NS_ASSUME_NONNULL_END
