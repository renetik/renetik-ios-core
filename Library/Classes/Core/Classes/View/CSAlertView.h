//
// Created by inno on 1/31/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "CSLang.h"
#import "NSDictionary+CSExtension.h"
#import "NSArray+CSExtension.h"
#import "NSMutableArray+CSExtension.h"
#import "UIView+CSExtension.h"
#import "NSMutableDictionary+CSExtension.h"
#import "NSObject+CSExtension.h"
#import "UIViewController+CSExtension.h"
#import "UIImageView+CSExtension.h"
#import "NSIndexPath+CSExtension.h"
#import "UIDevice+CSExtension.h"
#import "UIScrollView+CSExtension.h"
#import "NSString+CSExtension.h"
#import "UIPickerView+CSExtension.h"
#import "NSLocale+CSExtension.h"
#import "NSUserDefaults+CSExtension.h"
#import "UIButton+CSExtension.h"
#import "UITableViewCell+CSExtension.h"
#import "UINavigationController+CSExtension.h"
#import "UIToolbar+CSExtension.h"
#import "UITableView+CSExtension.h"
#import "UIControl+CSExtension.h"
#import "UIImage+CSExtension.h"
#import "NSData+CSExtension.h"
#import "NSDate+CSExtensions2.h"
#import "NSDate+CSExtension.h"
#import "CSViewControllerProtocol.h"
#import "NSDateFormatter+CSExtension.h"
#import "UIColor+CSExtension.h"
#import "CALayer+CSExtension.h"
#import "UICollectionView+CSExtension.h"
#import "UINib+CSExtension.h"
#import "UIBarButtonItem+CSExtension.h"
#import "UICollectionViewCell+CSExtension.h"
#import "NSBundle+CSExtension.h"
#import "UIApplication+CSExtension.h"


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
