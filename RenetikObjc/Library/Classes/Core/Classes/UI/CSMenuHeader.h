//
// Created by Rene Dohan on 14/03/18.
//
@import Foundation;

@class CSMenuItem;
@class CSMainController;

NS_ASSUME_NONNULL_BEGIN
@interface CSMenuHeader : NSObject

@property (nonatomic, strong) NSMutableArray<CSMenuItem *> *items;
@property (nonatomic, copy) NSString *title;
@property (nonatomic) NSInteger index;

- (instancetype)construct :(CSMainController *)controller
                          :(NSInteger)index :(NSString *)title;

- (CSMenuItem *)item :(NSString *)name;

- (CSMenuItem *)item :(NSString *)name :(NSString *)subTitle
                     :(void (^)(CSMenuItem *))onClick;

- (CSMenuItem *)item :(NSString *)title :(void (^)(CSMenuItem *))onClick;

- (CSMenuItem *)item :(NSString *)title type :(UIBarButtonSystemItem)type;

- (CSMenuItem *)item :(NSString *)title image :(UIImage *)image;

- (CSMenuItem *)item :(NSString *)title type :(UIBarButtonSystemItem)type :(void (^)(CSMenuItem *))onClick;

- (CSMenuItem *)itemView :(UIView *)view;

- (BOOL)visible;

- (instancetype)clear;

- (BOOL)isDisplayedAsItem;

@end
NS_ASSUME_NONNULL_END
