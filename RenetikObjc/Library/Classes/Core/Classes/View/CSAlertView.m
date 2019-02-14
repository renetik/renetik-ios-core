//
// Created by inno on 1/31/13.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import "CSAlertView.h"
#import "NSMutableArray+CSExtension.h"
#import "CSLang.h"

@implementation CSAlertView {
    NSMutableArray *_actions;
}

- (instancetype)create :(NSString *)title :(NSString *)message {
    _alert = [[UIAlertView alloc] initWithTitle :title message :message delegate :self cancelButtonTitle :nil otherButtonTitles :nil];
    _actions = NSMutableArray.new;
    return self;
}

- (instancetype)create :(NSString *)title :(NSString *)message :(NSString *)button1 :(void (^)(void))button1Action :(NSString *)button2 :(void (^)(void))button2Action {
    [self create :title :message];
    [self addButton :button1 :button1Action];
    [self addButton :button2 :button2Action];
    return self;
}

- (instancetype)create :(NSString *)title :(NSString *)message :(NSString *)button1 :(void (^)(void))button1Action :(NSString *)button2 :(void (^)(void))button2Action
                       :(NSString *)button3 :(void (^)(void))button3Action {
    [self create :title :message];
    [self addButton :button1 :button1Action];
    [self addButton :button2 :button2Action];
    [self addButton :button3 :button3Action];
    return self;
}

- (void)addButton :(NSString *)button :(void (^)(void))buttonAction {
    [_alert addButtonWithTitle :button];
    [_actions add :[buttonAction copy]];
}

- (instancetype)create :(NSString *)title :(NSString *)message :(NSString *)cancelTitle :(NSString *)okTitle :(void (^)(void))onSubmit onCancel :(void (^)(void))onCancel {
    [self create :title :message];
    __weak typeof(self)_self = self;
    [self addButton :cancelTitle :^{
        [_self hide];
        run(onCancel);
    }];
    [self addButton :okTitle :onSubmit];
    return self;
}

- (instancetype)create :(NSString *)title :(NSString *)message :(NSString *)cancelTitle :(NSString *)okTitle :(void (^)(void))onSubmit {
    [self create :title :message];
    [self addButton :cancelTitle :[self createHideAction]];
    [self addButton :okTitle :onSubmit];
    return self;
}

- (void (^)(void))createHideAction {
    return ^{
               [self hide];
    };
}

- (CSAlertView *)show :(NSString *)title :(NSString *)message :(NSString *)button1 :(void (^)(void))button1Action :(NSString *)button2 :(void (^)(void))button2Action {
    return [[self create :title :message :button1 :button1Action :button2 :button2Action] show];
}

- (CSAlertView *)show :(NSString *)title :(NSString *)message :(NSString *)cancelTitle :(NSString *)okTitle :(void (^)(void))onSubmit {
    return [[self create :title :message :cancelTitle :okTitle :onSubmit] show];
}

- (CSAlertView *)show :(NSString *)title :(NSString *)message :(NSString *)cancelTitle :(NSString *)okTitle :(void (^)(void))onSubmit onCancel :(void (^)(void))onCancel {
    return [[self create :title :message :cancelTitle :okTitle :onSubmit onCancel :onCancel] show];
}

- (CSAlertView *)show :(NSString *)title :(NSString *)message :(NSString *)cancelTitle :(NSString *)button1 :(void (^)(void))button1Action :(NSString *)button2 :(void (^)(void))button2Action {
    [self create :title :message :cancelTitle :button1 :button1Action];
    [self addButton :button2 :button2Action];
    return [self show];
}

- (CSAlertView *)show :(NSString *)title :(NSString *)message :(NSString *)okTitle {
    [self create :title :message];
    [self addButton :okTitle :[self createHideAction]];
    return [self show];
}

- (CSAlertView *)show :(NSString *)title :(NSString *)message :(NSString *)okTitle :(void (^)(void))onSubmit {
    [self create :title :message];
    [self addButton :okTitle :onSubmit];
    return [self show];
}

- (void)alertView :(UIAlertView *)alertView clickedButtonAtIndex :(NSInteger)buttonIndex {
    [self onDone];
    run(_actions[(NSUInteger)buttonIndex]);
}

- (void)onDone {
    _visible = NO;
    _alert.delegate = nil; //fixing crash http://stackoverflow.com/questions/19001528/ios-7-bug-or-my-bug-in-uialertview
}

- (void)alertView :(UIAlertView *)alertView didDismissWithButtonIndex :(NSInteger)buttonIndex {
    [self onDone];
}

- (CSAlertView *)show {
    if (_visible) return self;
    [_alert show];
    _visible = YES;
    return self;
}

- (void)hide {
    if (!_visible) return;
    _visible = NO;
    [_alert dismissWithClickedButtonIndex :-1 animated :YES];
}

- (UITextField *)textField {
    return [_alert textFieldAtIndex :0];
}

- (instancetype)setText :(NSString *)text {
    self.textField.text = text;
    return self;
}

- (instancetype)setPlaceholder :(NSString *)text {
    self.textField.placeholder = text;
    return self;
}

- (instancetype)setKeyboardType :(UIKeyboardType)keyboardType {
    [self.textField setKeyboardType :keyboardType];
    return self;
}

- (NSString *)text {
    return self.textField.text;
}

- (instancetype)withInput {
    _alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    return self;
}

- (instancetype)withSecureInput {
    _alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
    return self;
}

@end
