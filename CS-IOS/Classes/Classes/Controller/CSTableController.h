//
//  Created by Rene Dohan on 1/11/13.
//


#import <Foundation/Foundation.h>
#import "CSViewController.h"
#import "CSChildViewLessController.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@class CSResponse;

@interface CSTableController<__covariant ObjectType> : CSChildViewLessController <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property(nonatomic, strong, readonly) UITableView *table;

@property(nonatomic, copy) CSResponse *(^onReload)(BOOL isUserAction);

@property(nonatomic, copy) CSResponse *(^onLoadNext)();

@property(nonatomic, copy) BOOL (^onUserRefresh)();

@property(nonatomic, strong) NSString *searchText;

@property(nonatomic, copy) BOOL (^shouldLoadNext)(NSIndexPath *);

@property(nonatomic, copy) NSString *emptyText;

@property(nonatomic, copy) NSString *emptyDescription;

@property(nonatomic) BOOL loading;

@property(nonatomic, strong) UIView *loadNextView;

@property(nonatomic) BOOL autoReload;

- (void)insertItem:(id)item :(int)index;

- (void)onReloadSuccess:(NSArray<ObjectType> *)array;

- (void)filterDataAndReload;

- (void)onLoadNextSuccess:(NSArray<ObjectType> *)array;

- (void)onLoadNextSectionsSuccess:(NSArray<ObjectType> *)array;

- (instancetype)construct:(CSMainController <CSViewControllerProtocol, UITableViewDataSource, UITableViewDelegate> *)parent :(UITableView *)table refreshable:(BOOL)refreshable;

- (instancetype)construct:(CSMainController <CSViewControllerProtocol, UITableViewDataSource, UITableViewDelegate> *)parent :(UITableView *)table;

- (instancetype)construct:(CSMainController <CSViewControllerProtocol, UITableViewDataSource, UITableViewDelegate> *)parent :(UITableView *)table :(NSArray *)data;

- (void)tableViewWillDisplayCellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (CSResponse *)reload;

- (void)addItem:(id)dog;

- (void)removeItem:(id)item;

- (void)removeItemAtIndex:(NSUInteger)i;

- (void)cancelUserRefresh;

- (CSTableController *)onReload:(CSResponse *(^)(BOOL))pFunction;

- (ObjectType)dataFor:(NSIndexPath *)path;

- (NSUInteger)dataCount;

- (ObjectType)lastData;

- (ObjectType)dataForRow:(NSInteger)row;

- (id <NSFastEnumeration>)data;

@end