//
// Created by Rene Dohan on 14/03/18.
//

#import <Foundation/Foundation.h>

@class CSMenuItem;
@class CSMainController;

@interface CSMenuHeader : NSObject

@property(nonatomic, strong) NSMutableArray<CSMenuItem *> *items;
@property(nonatomic, copy) NSString *title;
@property(nonatomic) int index;

- (instancetype)construct:(CSMainController *)controller :(int)index :(NSString *)title;

- (CSMenuItem *)item:(NSString *)name;

- (CSMenuItem *)item:(NSString *)name :(NSString *)subTitle :(void (^)(CSMenuItem *))onClick;

- (CSMenuItem *)item:(NSString *)title :(void (^)(CSMenuItem *))onClick;

- (instancetype)clear;

- (CSMenuItem *)item:(NSString *)title type:(UIBarButtonSystemItem)type;

- (CSMenuItem *)item:(NSString *)title image:(UIImage *)image;

- (CSMenuItem *)item:(NSString *)title type:(UIBarButtonSystemItem)type :(void (^)(CSMenuItem *))onClick;

- (BOOL)visible;

- (CSMenuItem *)itemView:(UIView *)view;

- (BOOL)isDisplayedAsItem;

@end