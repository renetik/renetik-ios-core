//
//  Created by Rene Dohan on 1/11/13.
//

@import UIKit;
@import DZNEmptyDataSet;

#import "CSViewController.h"

@class CSResponse;
@class CSMainController;
@protocol CSListData;
@protocol CSViewControllerProtocol;

NS_ASSUME_NONNULL_BEGIN

@interface CSTableController<__covariant ObjectType> : CSViewController

@property(readonly, nonatomic) UITableView *tableView;

- (instancetype)construct:(CSMainController <CSViewControllerProtocol, UITableViewDataSource, UITableViewDelegate> *)parent :(UIView *)parentView :(NSArray *)data;

- (instancetype)construct:(CSMainController <CSViewControllerProtocol, UITableViewDataSource, UITableViewDelegate> *)parent parentView:(UIView *)parentView;

- (instancetype)construct:(CSMainController <CSViewControllerProtocol, UITableViewDataSource, UITableViewDelegate> *)parent :(NSArray *)data;

- (instancetype)construct:(CSMainController <CSViewControllerProtocol, UITableViewDataSource, UITableViewDelegate> *)parent;

@property(nonatomic) BOOL (^ onUserRefresh)(void);

@property(nonatomic) NSString *searchText;

@property(nonatomic) BOOL (^ shouldLoadNext)(NSIndexPath *);

@property(nonatomic) UIView *loadNextView;

@property(nonatomic) BOOL isLoading;

@property(nonatomic) BOOL isFailed;

@property(nonatomic, copy) NSString *failedMessage;

@property(nonatomic) NSInteger pageIndex;

@property(nonatomic, readonly) NSArray<ObjectType> *data;

- (instancetype)onLoad:(CSResponse *(^)())function;

- (instancetype)onLoadPage:(CSResponse *(^)(NSInteger))function;

- (CSResponse *)reload;

- (CSResponse *)reload:(BOOL)showProgress;

- (instancetype)load:(NSArray<ObjectType> *)array;

- (void)loadAdd:(NSArray<ObjectType> *)array;

- (void)insertItem:(id)item :(NSInteger)index;

- (void)filterDataAndReload;

- (void)onLoadNextSectionsSuccess:(NSArray<ObjectType> *)array;

- (instancetype)refreshable;

- (void)tableViewWillDisplayCellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)addItem:(ObjectType)item;

- (void)removeItem:(ObjectType)item;

- (void)removeItemAtIndex:(NSUInteger)index;

- (ObjectType)dataFor:(NSIndexPath *)path;

- (void)clearData;

- (BOOL)isAtBottom;

- (instancetype)scrollToBottom;

@end

NS_ASSUME_NONNULL_END
