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

@property(nonatomic) CSResponse *(^onLoad)(int);

@property(nonatomic) BOOL (^onUserRefresh)(void);

@property(nonatomic) NSString *searchText;

@property(nonatomic) NSString *emptyText;

@property(nonatomic) NSString *emptyDescription;

@property(nonatomic) BOOL (^shouldLoadNext)(NSIndexPath *);

@property(nonatomic) UIView *loadNextView;

@property(nonatomic) int pageIndex;

@property(nonatomic, readonly) NSArray<ObjectType> *data;

@property(nonatomic, strong) UIImage *reloadImage;

- (void)insertItem:(id)item :(int)index;

- (instancetype)autoReload;

- (void)filterDataAndReload;

- (instancetype)onLoadSuccess:(NSArray<ObjectType> *)array;

- (void)onLoadNextSectionsSuccess:(NSArray<ObjectType> *)array;

- (instancetype)construct:(CSMainController <CSViewControllerProtocol, UITableViewDataSource, UITableViewDelegate> *)parent :(UITableView *)table;

- (instancetype)construct:(CSMainController <CSViewControllerProtocol, UITableViewDataSource, UITableViewDelegate> *)parent :(UITableView *)table :(NSArray *)data;

- (instancetype)refreshable;

- (void)tableViewWillDisplayCellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (CSResponse *)reload;

- (void)addItem:(ObjectType)item;

- (void)removeItem:(ObjectType)item;

- (void)removeItemAtIndex:(NSUInteger)index;

- (ObjectType)dataFor:(NSIndexPath *)path;

@end