//
// Created by inno on 1/31/13.
//
// To change the template use AppCode | Preferences | File Templates.
//

@import UIKit;

@interface CSAlertView : NSObject <UIAlertViewDelegate>

@property(nonatomic, strong) UIAlertView *alert;

@property(nonatomic, readonly) BOOL visible;

@property(nonatomic, readonly) UITextField *textField;

- (instancetype)show;

- (instancetype)show:(NSString *)title :(NSString *)message :(NSString *)cancelTitle :(NSString *)okTitle :(void (^)(void))onSubmit;

- (CSAlertView *)show:(NSString *)title :(NSString *)message :(NSString *)cancelTitle :(NSString *)okTitle :(void (^)(void))onSubmit onCancel:(void (^)(void))onCancel;

- (CSAlertView *)show:(NSString *)title :(NSString *)message :(NSString *)cancelTitle :(NSString *)button1 :(void (^)(void))button1Action :(NSString *)button2 :(void (^)(void))button2Action;

- (CSAlertView *)show:(NSString *)title :(NSString *)message :(NSString *)okTitle;

- (CSAlertView *)show:(NSString *)title :(NSString *)message :(NSString *)okTitle :(void (^)(void))onSubmit;

- (CSAlertView *)show:(NSString *)title :(NSString *)message :(NSString *)button1 :(void (^)(void))button1Action :(NSString *)button2 :(void (^)(void))button2Action;

- (instancetype)create:(NSString *)title :(NSString *)message :(NSString *)button1 :(void (^)(void))button1Action :(NSString *)button2 :(void (^)(void))button2Action :(NSString *)button3 :(void (^)(void))button3Action;

- (instancetype)create:(NSString *)title :(NSString *)message;

- (instancetype)create:(NSString *)title :(NSString *)message :(NSString *)button1 :(void (^)(void))button1Action :(NSString *)button2 :(void (^)(void))button2Action;

- (CSAlertView *)create:(NSString *)title :(NSString *)message :(NSString *)cancelTitle :(NSString *)okTitle :(void (^)(void))onSubmit;

- (void)hide;

- (instancetype)setText:(NSString *)text;

- (instancetype)setPlaceholder:(NSString *)text;

- (instancetype)setKeyboardType:(UIKeyboardType)keyboardType;

- (NSString *)text;

- (instancetype)withInput;

- (instancetype)withSecureInput;
@end
