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

- (instancetype)construct:(CSMainController <CSViewControllerProtocol, UITableViewDataSource, UITableViewDelegate> *)parent;

- (instancetype)construct:(CSMainController <CSViewControllerProtocol, UITableViewDataSource, UITableViewDelegate> *)parent :(NSArray *)data;

@property(nonatomic) CSResponse <CSListData> *(^onLoadList)(NSInteger);

@property(nonatomic) CSResponse *(^onLoad)(NSInteger);

@property(nonatomic) BOOL (^onUserRefresh)(void);

@property(nonatomic) NSString *searchText;

@property(nonatomic) NSString *emptyText;

@property(nonatomic) NSString *emptyDescription;

@property(nonatomic) BOOL (^shouldLoadNext)(NSIndexPath *);

@property(nonatomic) UIView *loadNextView;

@property(nonatomic) NSInteger pageIndex;

@property(nonatomic, readonly) NSArray<ObjectType> *data;

@property(nonatomic, strong) UIImage *reloadImage;

- (void)insertItem:(id)item :(NSInteger)index;

- (instancetype)autoReload;

- (void)filterDataAndReload;

- (instancetype)onLoadSuccess:(NSArray<ObjectType> *)array;

- (void)onLoadNextSectionsSuccess:(NSArray<ObjectType> *)array;

- (instancetype)refreshable;

- (void)tableViewWillDisplayCellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (CSResponse *)reload;

- (void)addItem:(ObjectType)item;

- (void)removeItem:(ObjectType)item;

- (void)removeItemAtIndex:(NSUInteger)index;

- (ObjectType)dataFor:(NSIndexPath *)path;

- (void)clearData;

@end

NS_ASSUME_NONNULL_END
