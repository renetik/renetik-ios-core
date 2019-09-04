//
//  Created by Rene Dohan on 1/11/13.
//

@import ChameleonFramework;
@import BlocksKit;

#import "CSMainController.h"
#import "CSLang.h"
#import "CSTableController.h"
#import "CSResponse.h"
#import "CSRefreshControl.h"
#import "CSWork.h"
#import "CSTableFilterProtocol.h"
#import "CSViewControllerProtocol.h"
#import "UIView+CSPosition.h"
#import "UIView+CSExtension.h"
#import "UIViewController+CSExtension.h"
#import "NSObject+CSExtension.h"
#import "NSMutableArray+CSExtension.h"
#import "NSArray+CSExtension.h"
#import "NSString+CSExtension.h"
#import "UIImage+CSExtension.h"
#import "NSIndexPath+CSExtension.h"
#import "UIView+CSDimension.h"
#import "UIView+CSLayout.h"
#import "UIDevice+CSExtension.h"
#import "UIScreen+CSExtension.h"

@interface CSTableController ()
@property(nonatomic, strong) CSRefreshControl *refreshControl;
@property(nonatomic) CSResponse *(^ onLoad)();
@property(nonatomic) CSResponse *(^ onLoadPage)(NSInteger);
@end

@implementation CSTableController {
    UIViewController <CSViewControllerProtocol> *_parent;
    BOOL _noNext;
    CSResponse *_loadResponse;
    NSMutableArray *_filteredData;
    NSMutableArray *_data;
    UIColor *_loadNextColor;
    id <CSTableFilterProtocol> _filter;
}

- (instancetype)init {
    super.init;
    _tableView = UITableView.construct;
    _tableView.estimatedRowHeight = 0;
    return self;
}

- (void)loadView {
    self.view = _tableView;
}

- (instancetype)construct:(CSMainController <CSViewControllerProtocol, UITableViewDataSource, UITableViewDelegate> *)parent :(UIView *)parentView :(NSArray *)data {
    _parent = parent;
    _filter = [_parent as:@protocol(CSTableFilterProtocol)];
    _filteredData = NSMutableArray.new;
    _data = muteArray(data);
    [self initializeTable:parent];
    [parent showChildController:self :parentView];
    _pageIndex = -1;
    return self;
}

- (instancetype)construct
        :(CSMainController <CSViewControllerProtocol, UITableViewDataSource, UITableViewDelegate> *)parent
        :(NSArray *)data {
    return [self construct:parent :parent.view :data];
}

- (instancetype)construct
        :(CSMainController <CSViewControllerProtocol,
        UITableViewDataSource, UITableViewDelegate> *)parent
               parentView:(UIView *)parentView {
    return [self construct:parent :parentView :NSMutableArray.new];
}

- (instancetype)construct:(CSMainController <CSViewControllerProtocol, UITableViewDataSource, UITableViewDelegate> *)parent {
    return [self construct:parent :NSMutableArray.new];
}

- (instancetype)refreshable {
    _refreshControl = [CSRefreshControl.new construct
    :_tableView :^{
        self.onRefreshControl;
    }];
    return self;
}

- (void)initializeTable:(CSMainController <CSViewControllerProtocol, UITableViewDataSource, UITableViewDelegate> *)parent {
    _tableView.hide;
    _tableView.delegate = parent;
    _tableView.dataSource = parent;
}

- (void)onViewWillTransitionToSizeCompletion
        :(CGSize)size :(id <UIViewControllerTransitionCoordinatorContext>)context {
    _tableView.reloadData;
}

- (void)onViewWillAppearFromPresentedController {
    super.onViewWillAppearFromPresentedController;
    _tableView.reloadData;
}

- (instancetype)onLoadPage:(CSResponse *(^)(NSInteger))function {
    self.onLoadPage = [function copy];
    return self;
}

- (instancetype)onLoad:(CSResponse *(^)())function {
    self.onLoad = [function copy];
    return self;
}

- (CSResponse *)reload {
    return [self reload:YES];
}

- (CSResponse *)reload:(BOOL)showProgress {
    wvar _self = self;
    if (_isLoading) _loadResponse.cancel;
    _noNext = NO;
    _pageIndex = -1;
    _isLoading = YES;
    _loadResponse = self.onLoad ? self.onLoad() : self.onLoadPage(0);
    if (showProgress) [_parent showProgress:_loadResponse];
    [_loadResponse onFailed:^(CSResponse *response) {
        _self.isFailed = YES;
        _self.failedMessage = response.message;
        _tableView.reloadData;
    }];
    [_loadResponse onCancel:^(CSResponse *response) {
        _self.isFailed = YES;
        _self.failedMessage = response.message;
        _tableView.reloadData;
    }];
    return [_loadResponse onDone:^(id data) {
        _self.tableView.fadeIn;
        _self.refreshControl.endRefreshing;
        _self.isLoading = NO;
    }];
}

- (void)loadNext {
    if (!self.onLoadPage) return;
    if (_isLoading) return;
    _isLoading = YES;
    self.showLoadNextIndicator;
    wvar _self = self;
    [_parent showFailed:[self.onLoadPage(_pageIndex + 1) onDone:^(id data) {
        _self.isLoading = NO;
        _self.loadNextView.removeFromSuperview;
    }]];
}

- (instancetype)load:(NSArray *)array {
    if (_pageIndex == -1) {
        [_data reload:array];
        self.filterDataAndReload;
    } else [self loadAdd:array];
    if (array.hasItems) _pageIndex += 1;
    else _noNext = YES;
    _isFailed = NO;
    return self;
}

- (void)loadAdd:(NSArray *)array {
    [_data addArray:array];
    let filteredData = [self filterData:array];

    let paths = NSMutableArray.new;
    for (int index = 0; index < filteredData.count; index++)
        [paths put:[NSIndexPath indexPathForRow:index + _filteredData.count inSection:0]];

    [_filteredData addArray:filteredData];
    _tableView.beginUpdates;
    [_tableView insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationAutomatic];
    _tableView.endUpdates;
}

- (void)showLoadNextIndicator {
    if (!_loadNextView) {
        let loadingNextView = [UIActivityIndicatorView.alloc initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        if (_loadNextColor) loadingNextView.color = _loadNextColor;
        loadingNextView.startAnimating;
        _loadNextView = loadingNextView;
    }
    [[_tableView.superview add:_loadNextView] fromBottom:5].centerInParentHorizontal;
}

- (BOOL)shouldLoadNext:(NSIndexPath *)path {
    if (_isLoading) return NO;
    var loadStartIndex = 5;
    if (UIScreen.isPortrait && UIDevice.iPad) loadStartIndex = 10;
    if (UIScreen.isLandscape && UIDevice.iPad) loadStartIndex = 9;
    if (UIScreen.isPortrait && UIDevice.iPhone) loadStartIndex = 8;
    if (UIScreen.isLandscape && UIDevice.iPhone) loadStartIndex = 7;
    return !_noNext && (_shouldLoadNext ? _shouldLoadNext(path) : path.index >= _data.count - loadStartIndex);
}

- (void)tableViewWillDisplayCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self shouldLoadNext:indexPath]) self.loadNext;
}

- (void)onRefreshControl {
    if (self.onUserRefresh) {
        if (self.onUserRefresh()) [self reload:NO];
    } else [self reload:NO];
}

- (void)setSearchText:(NSString *)text {
    _searchText = text;
    self.filterDataAndReload;
}

- (NSArray *)filterData:(NSArray *)toFilter {
    return [self filterByFilter:[toFilter filterBySearch:_searchText]];
}

- (NSArray *)filterByFilter:(NSArray *)toFilter {
    if ([_filter respondsToSelector:@selector(filterData:)]) return [NSMutableArray arrayWithArray:[_filter filterData:toFilter]];
    return toFilter;
}

- (void)onLoadNextSectionsSuccess:(NSArray *)array {
    if ((_noNext = !array.hasItems)) return;
    [_data addArray:array];
    let filteredData = [self filterData:array];
    let indexes = NSMutableIndexSet.new;
    for (int section = 0; section < filteredData.count; section++)
        [indexes addIndex:section + _filteredData.count];
    [_filteredData addArray:filteredData];
    _tableView.beginUpdates;
    [_tableView insertSections:indexes withRowAnimation:UITableViewRowAnimationAutomatic];
    _tableView.endUpdates;
}

- (void)addItem:(id)item {
    [_data addObject:item];
    self.filterDataAndReload;
}

- (void)insertItem:(id)item :(int)index {
    [_data insertObject:item atIndex:(uint) index];
    self.filterDataAndReload;
}

- (void)removeItem:(id)item {
    [_data removeObject:item];
    self.filterDataAndReload;
}

- (void)removeItemAtIndex:(NSUInteger)index {
    [_data removeObjectAtIndex:index];
    self.filterDataAndReload;
}

- (id)dataFor:(NSIndexPath *)path {
    return _filteredData[path.index];
}

- (NSArray *)data {
    return _filteredData;
}

- (void)filterDataAndReload {
    [_filteredData reload:[self filterData:_data]];
    _tableView.reloadData;
    if ([_filter respondsToSelector:@selector(onReloadDone:)]) [_filter onReloadDone:self];
}

- (void)clearData {
    _data.removeAllObjects;
    _filteredData.removeAllObjects;
    _tableView.reloadData;
}

- (instancetype)scrollToBottom {
    if (_filteredData.hasItems)
        invoke(^{
            let path = [NSIndexPath indexPathForRow:_filteredData.count - 1];
            [self.tableView
                    scrollToRowAtIndexPath:path
                          atScrollPosition:UITableViewScrollPositionBottom
                                  animated:true];
        });
    return self;
}

- (BOOL)isAtBottom {
    let lastPath = self.tableView.indexPathsForVisibleRows.last;
    if (!lastPath) return YES;
    if (lastPath.row == _filteredData.count - 1) return YES;
    else return NO;
}

@end
