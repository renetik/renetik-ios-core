//
//  Created by Rene Dohan on 1/11/13.
//

#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import <ChameleonFramework/ChameleonMacros.h>
#import "CSTableController.h"
#import "CSResponse.h"
#import "CSRefreshControl.h"
#import "CSWork.h"
#import "CSTableFilterProtocol.h"

@implementation CSTableController {
    UIViewController <CSViewControllerProtocol> *_parent;
    BOOL _noNext;
    CSResponse *_loadResponse;
    NSMutableArray *_filteredData;
    NSMutableArray *_data;
    UIColor *_loadNextColor;
    CSRefreshControl *_refreshControl;
    BOOL _failed;
    CSWork *_reloadWork;
    id <CSTableFilterProtocol> _filter;
}

- (instancetype)construct:(CSMainController <CSViewControllerProtocol, UITableViewDataSource, UITableViewDelegate> *)parent :(UITableView *)table refreshable:(BOOL)refreshable {
    return [self construct:parent :table :NSMutableArray.new :refreshable :nil];
}

- (instancetype)construct:(CSMainController <CSViewControllerProtocol, UITableViewDataSource, UITableViewDelegate> *)parent :(UITableView *)table {
    return [self construct:parent :table :NSMutableArray.new :YES :nil];
}

- (instancetype)construct:(CSMainController <CSViewControllerProtocol, UITableViewDataSource, UITableViewDelegate> *)
        parent :(UITableView *)table :(NSArray *)data {
    return [self construct:parent :table :data :YES :nil];
}

- (instancetype)construct:(CSMainController <CSViewControllerProtocol, UITableViewDataSource, UITableViewDelegate> *)
        parent :(UITableView *)table :(NSArray *)data :(BOOL)refreshable :(UIColor *)loadNextColor {
    [super construct:parent];
    [parent addController:self];
    _parent = parent;
    _filter = (id <CSTableFilterProtocol>) ([_parent conformsToProtocol:@protocol(CSTableFilterProtocol)] ? _parent : nil);
    _table = table;
    _table.delegate = parent;
    _table.dataSource = parent;
    _table.emptyDataSetSource = self;
    _table.emptyDataSetDelegate = self;
    [_table hide];
    _filteredData = NSMutableArray.new;
    _data = [NSMutableArray arrayWithArray:data];
    _loadNextColor = loadNextColor;
    if (refreshable)
        _refreshControl = [CSRefreshControl.new construct:_table :(self) :@selector(csTableControllerOnRefreshUserAction)];
    _table.backgroundView = [UIView createEmptyWithColor:UIColor.clearColor];
    [_table.backgroundView addGestureRecognizer:[UITapGestureRecognizer.alloc initWithTarget:self action:@selector(csTableControllerOnBackTapUserAction)]];
    return self;
}

- (void)csTableControllerOnBackTapUserAction {
    [self reload];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadData];
}

- (void)reloadData {
    [_table reloadData];
    if ([_filter respondsToSelector:@selector(onReloadDone:)])[_filter onReloadDone:self];
}

- (void)onViewWillAppearFromPresentedController {
    [super onViewWillAppearFromPresentedController];
    if (self.autoReload)[_reloadWork run];
}

- (void)setAutoReload:(BOOL)autoReload {
    _autoReload = autoReload;
    _reloadWork = [[CSWork.new construct:_autoReload :^{
        if (self.visible) [self load:YES];
    }] start];
}

- (void)loadNext {
    if (_loading)return;
    _loading = YES;
    [self showLoadNextIndicator];
    __weak typeof(self) _self = self;
    [_onLoadNext() onDone:^(id data) {
        _self.loading = NO;
        [_self.loadNextView removeFromSuperview];
    }];
}

- (void)showLoadNextIndicator {
    if (!_loadNextView) {
        UIActivityIndicatorView *loadingNextView = [UIActivityIndicatorView.alloc initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        loadingNextView.color = (_loadNextColor) ? _loadNextColor : UIColor.blackColor;
        [loadingNextView startAnimating];
        _loadNextView = loadingNextView;
    }
    _loadNextView.center = CGPointMake(_table.center.x, _table.bottom - _loadNextView.height / 2);
    [_table.superview addSubview:_loadNextView];
}

- (BOOL)shouldLoadNext:(NSIndexPath *)path {
    if (_loading)return NO;
    if (!_onLoadNext)return NO;
    return !_noNext && (_shouldLoadNext ? _shouldLoadNext(path) : path.index >= _data.count - 5);
}

- (void)tableViewWillDisplayCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self shouldLoadNext:indexPath]) [self loadNext];
}

- (void)csTableControllerOnRefreshUserAction {
    if (self.onUserRefresh) {
        if (self.onUserRefresh())[self load:YES];
    } else [self load:YES];
}

- (CSResponse *)reload {
    return [self load:NO];
}

- (CSResponse *)load:(BOOL)isUserAction {
    if (_loading) [_loadResponse cancel];
    __weak typeof(self) _self = self;
    _noNext = NO;
    _loading = YES;
    _loadResponse = self.onReload(isUserAction);
    if (!isUserAction) [_parent showProgress:_loadResponse];
    return [[[_loadResponse onSuccess:^(id o) {
        _failed = NO;
    }] onDone:^(id data) {
        if (isUserAction) [_self cancelUserRefresh];
        _self.loading = NO;
        [_self.table fadeIn];
    }] onFailed:^(CSResponse *response) {
        _failed = YES;
    }];
}

- (void)setSearchText:(NSString *)text {
    _searchText = text;
    [self filterDataAndReload];
}

- (void)onReloadSuccess:(NSArray *)array {
    [_data replaceFromArray:array];
    [_filteredData replaceFromArray:[self filterData:_data]];
    _noNext = array.count == 0;
    [self reloadData];
}

- (void)filterDataAndReload {
    [_filteredData replaceFromArray:[self filterData:_data]];
    [self reloadData];
}

- (NSArray *)filterData:(NSArray *)toFilter {
    return [self filterByFilter:[self filterBySearch:toFilter]];
}

- (NSArray *)filterBySearch:(NSArray *)toFilter {
    if (_searchText.set) {
        NSMutableArray *filtered = NSMutableArray.new;
        for (id item in toFilter)
            if ([[item description] containsNoCase:_searchText]) [filtered add:item];
        return filtered;
    }
    return toFilter;
}

- (NSArray *)filterByFilter:(NSArray *)toFilter {
    if ([_filter respondsToSelector:@selector(filterData:)])
        return [NSMutableArray arrayWithArray:[_filter filterData:toFilter]];
    return toFilter;
}

- (void)onLoadNextSuccess:(NSArray *)array {
    _noNext = array.count == 0;
    if (_noNext)return;

    [_data addObjectsFromArray:array];
    NSArray *filteredData = [self filterData:array];

    NSMutableArray *indexPaths = NSMutableArray.new;
    for (int i = 0; i < filteredData.count; i++) [indexPaths addObject:[NSIndexPath indexPathForRow:i + _filteredData.count inSection:0]];

    [_filteredData addObjectsFromArray:filteredData];
    [_table beginUpdates];
    [_table insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    [_table endUpdates];
}

- (void)onLoadNextSectionsSuccess:(NSArray *)array {
    _noNext = array.count == 0;
    if (_noNext)return;

    [_data addObjectsFromArray:array];
    NSArray *filteredData = [self filterData:array];

    NSMutableIndexSet *indexes = NSMutableIndexSet.new;
    for (int section = 0; section < filteredData.count; section++) [indexes addIndex:section + _filteredData.count];

    [_filteredData addObjectsFromArray:filteredData];
    [_table beginUpdates];
    [_table insertSections:indexes withRowAnimation:UITableViewRowAnimationAutomatic];
    [_table endUpdates];
}

- (void)addItem:(id)item {
    [_data addObject:item];
    [_filteredData replaceFromArray:[self filterData:_data]];
    [self reloadData];
}

- (void)insertItem:(id)item :(int)index {
    [_data insertObject:item atIndex:(uint) index];
    [_filteredData replaceFromArray:[self filterData:_data]];
    [self reloadData];
}

- (void)removeItem:(id)item {
    [_data removeObject:item];
    [_filteredData replaceFromArray:[self filterData:_data]];
    [self reloadData];
}

- (void)removeItemAtIndex:(NSUInteger)index {
    [_data removeObjectAtIndex:index];
    [_filteredData replaceFromArray:[self filterData:_data]];
    [self reloadData];
}

- (void)cancelUserRefresh {
    [_refreshControl endRefreshing];
}

- (CSTableController *)onReload:(CSResponse *(^)(BOOL))pFunction {
    self.onReload = pFunction;
    return self;
}

- (id)dataFor:(NSIndexPath *)path {
    return _filteredData[path.index];
}

- (NSUInteger)dataCount {
    return _filteredData.count;
}

- (id)lastData {
    return _filteredData.last;
}

- (id)dataForRow:(NSInteger)row {
    return _filteredData[(NSUInteger) row];
}

- (id <NSFastEnumeration>)data {
    return _data;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    if (self.emptyText || _failed)
        return [NSAttributedString.alloc initWithString:self.emptyText attributes:@{NSFontAttributeName:
                [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline], NSForegroundColorAttributeName: FlatWhite}];
    return nil;
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    if (self.emptyDescription) {
        NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
        paragraph.alignment = NSTextAlignmentCenter;
        return [NSAttributedString.alloc initWithString:self.emptyDescription attributes:@{
                NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline],
                NSForegroundColorAttributeName: FlatWhiteDark,
                NSParagraphStyleAttributeName: paragraph}];
    }
    return nil;
}

- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation((CGFloat) M_PI_2, 0.0, 0.0, 1.0)];
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = 4;
    return animation;
}

- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView {
    return YES;
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIColor clearColor];
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
    [self reload];
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    [self reload];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return 130;
}

- (NSString *)emptyText {
    if (_failed) return @"Loading of content not successful, click to try again";
    return _emptyText;
}

@end