//
//  Created by Rene Dohan on 1/11/13.
//

#import <UIKit/UIKit.h>
#import "CSViewController.h"
#import "CSChildViewLessController.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@class CSResponse;

@interface CSTableController<__covariant ObjectType> : CSChildViewLessController

@property(readonly, nonatomic) UITableView *table;

@property(nonatomic) CSResponse * _Nonnull(^onLoad)(NSInteger);

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

- (instancetype _Nonnull)autoReload;

- (void)filterDataAndReload;

- (instancetype _Nonnull)onLoadSuccess:(NSArray<ObjectType> *)array;

- (void)onLoadNextSectionsSuccess:(NSArray<ObjectType> *)array;

- (instancetype _Nonnull)construct:(CSMainController <CSViewControllerProtocol, UITableViewDataSource, UITableViewDelegate> *)parent :(UITableView *)table;

- (instancetype _Nonnull)construct:(CSMainController <CSViewControllerProtocol, UITableViewDataSource, UITableViewDelegate> *)parent :(UITableView *)table :(NSArray *)data;

- (instancetype _Nonnull)refreshable;

- (void)tableViewWillDisplayCellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (CSResponse *)reload;

- (void)addItem:(ObjectType)item;

- (void)removeItem:(ObjectType)item;

- (void)removeItemAtIndex:(NSUInteger)index;

- (ObjectType)dataFor:(NSIndexPath *)path;

@end