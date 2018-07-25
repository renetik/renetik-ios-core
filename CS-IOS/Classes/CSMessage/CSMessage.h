//
// Created by Rene Dohan on 24/07/18.
//

#import "CS_IOS/CS-IOS-umbrella.h"

@import RMessage;

@interface CSMessage : NSObject

- (instancetype)bottom;

- (instancetype)top;

- (instancetype)navBar;

- (instancetype)title:(NSString *)title;

- (instancetype)title:(NSString *)title show:(UIViewController *)parent;

- (instancetype)subtitle:(NSString *)subtitle;

- (instancetype)dismissable:(BOOL)dismissable;

- (instancetype)hanging;

- (instancetype)show:(UIViewController *)parent;

- (instancetype)dismiss;

@end
