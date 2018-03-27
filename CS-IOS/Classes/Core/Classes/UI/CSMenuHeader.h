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

- (instancetype)clear;
@end