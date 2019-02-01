//
//  Created by Rene Dohan on 1/11/13.
//

@import DZNEmptyDataSet;
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
#import "CSListData.h"

@interface CSTableController () <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property (nonatomic) BOOL loading;
@property (nonatomic) BOOL failed;
@property (nonatomic, copy) NSString *failedMessage;
@property (nonatomic, strong) CSRefreshControl *refreshControl;
@end

@implementation CSTableController {
    UIViewController <CSViewControllerProtocol> *_parent;
    BOOL _noNext;
    CSResponse *_loadResponse;
    NSMutableArray *_filteredData;
    NSMutableArray *_data;
    UIColor *_loadNextColor;
    CSWork *_reloadWork;
    id <CSTableFilterProtocol> _filter;
    BOOL _autoReload;
}

- (void)loadView {
    self.view = _tableView = UITableView.new;
    [_tableView background :UIColor.clearColor];
}

- (instancetype)construct :(CSMainController <CSViewControllerProtocol, UITableViewDataSource, UITableViewDelegate> *)
                   parent :(NSArray *)data {
    _parent = parent;
    _filter = [_parent as :@protocol(CSTableFilterProtocol)];
    _filteredData = NSMutableArray.new;
    _data = muteArray(data);
    [parent showChildController :self];
    [self initializeTable :parent];
    return self;
}

- (instancetype)construct :(CSMainController <CSViewControllerProtocol, UITableViewDataSource, UITableViewDelegate> *)parent {
    return [self construct :parent :NSMutableArray.new];
}

- (instancetype)refreshable {
    _refreshControl = [CSRefreshControl.new construct :_tableView :^{ [self onRefreshControl]; }];
    return self;
}

- (instancetype)autoReload {
    _autoReload = YES;
    _reloadWork = [[CSWork.new construct :5 * MINUTE :^{ if (self.visible) [self reload :YES]; }] start];
    return self;
}

- (void)initializeTable :(CSMainController <CSViewControllerProtocol, UITableViewDataSource, UITableViewDelegate> *)parent {
    _tableView.hide;
    _tableView.delegate = parent;
    _tableView.dataSource = parent;
    _tableView.emptyDataSetSource = self;
    _tableView.emptyDataSetDelegate = self;
    _tableView.backgroundView = [UIView withColor :UIColor.clearColor];
    [UITapGestureRecognizer.alloc bk_initWithHandler :
     ^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
        [self reload];
    }];
}

- (void)onViewDidAppearFromPresentedController {
    super.onViewDidAppearFromPresentedController;
    if (_autoReload) [_reloadWork run];
}

- (void)onViewWillTransitionToSizeCompletion :(CGSize)size :(id <UIViewControllerTransitionCoordinatorContext>)context {
    [_tableView reloadData];
}

- (CSResponse *)reload {
    return [self reload :NO];
}

- (CSResponse *)reload :(BOOL)refreshControl {
    wvar _self = self;
    if (_loading) [_loadResponse cancel];
    _noNext = NO;
    _pageIndex = -1;
    _loading = YES;
    _loadResponse = [self createLoadResponse];
    if (!refreshControl) [_parent showProgress :_loadResponse];
    return [[_loadResponse onFailed :^(CSResponse *response) {
        _self.failed = YES;
        _self.failedMessage = response.message;
        [_tableView reloadData];
    }] onDone :^(id data) {
        if (refreshControl) [_self.refreshControl endRefreshing];
        _self.loading = NO;
        [_self.tableView fadeIn];
    }];
}

- (void)loadNext {
    if (_loading) return;
    _loading = YES;
    [self showLoadNextIndicator];
    wvar _self = self;
    [_parent showFailed :[self.createLoadResponse onDone :^(id data) {
        _self.loading = NO;
        [_self.loadNextView removeFromSuperview];
    }]];
}

- (CSResponse *)createLoadResponse {
    wvar _self = self;
    if (self.onLoadList)
        return [(self.onLoadList(_pageIndex + 1)) onSuccess :^(NSObject <CSListData> *data) {
            [_self onLoadSuccess :data.list];
        }];
    else return self.onLoad(_pageIndex + 1);
}

- (instancetype)onLoadSuccess :(NSArray *)array {
    if (_pageIndex == -1) {
        [_data reload :array];
        _noNext = array.empty;
        [self filterDataAndReload];
    } else {
        if ((_noNext = array.empty)) return self;
        [_data addArray :array];
        let filteredData = [self filterData :array];

        let paths = NSMutableArray.new;
        for (int index = 0; index < filteredData.count; index++)
            [paths add :[NSIndexPath indexPathForRow :index + _filteredData.count inSection :0]];

        [_filteredData addArray :filteredData];
        [_tableView beginUpdates];
        [_tableView insertRowsAtIndexPaths :paths withRowAnimation :UITableViewRowAnimationAutomatic];
        [_tableView endUpdates];
    }
    _pageIndex += 1;
    _failed = NO;
    return self;
}

- (void)showLoadNextIndicator {
    if (!_loadNextView) {
        UIActivityIndicatorView *loadingNextView =
            [UIActivityIndicatorView.alloc initWithActivityIndicatorStyle :UIActivityIndicatorViewStyleGray];
        if (_loadNextColor) loadingNextView.color = _loadNextColor;
        [loadingNextView startAnimating];
        _loadNextView = loadingNextView;
    }
    [[_tableView.superview add :_loadNextView] fromBottom :5].centerInParentHorizontal;
}

- (BOOL)shouldLoadNext :(NSIndexPath *)path {
    if (_loading) return NO;
    return !_noNext && (_shouldLoadNext ? _shouldLoadNext(path) : path.index >= _data.count - 5);
}

- (void)tableViewWillDisplayCellForRowAtIndexPath :(NSIndexPath *)indexPath {
    if ([self shouldLoadNext :indexPath]) [self loadNext];
}

- (void)onRefreshControl {
    if (self.onUserRefresh) {
        if (self.onUserRefresh()) [self reload :YES];
    } else [self reload :YES];
}

- (void)setSearchText :(NSString *)text {
    _searchText = text;
    [self filterDataAndReload];
}

- (NSArray *)filterData :(NSArray *)toFilter {
    return [self filterByFilter :[toFilter filterBySearch :_searchText]];
}

- (NSArray *)filterByFilter :(NSArray *)toFilter {
    if ([_filter respondsToSelector :@selector(filterData:)]) return [NSMutableArray arrayWithArray :[_filter filterData :toFilter]];
    return toFilter;
}

- (void)onLoadNextSectionsSuccess :(NSArray *)array {
    if ((_noNext = array.empty)) return;
    [_data addArray :array];
    let filteredData = [self filterData :array];
    let indexes = NSMutableIndexSet.new;
    for (int section = 0; section < filteredData.count; section++) [indexes addIndex :section + _filteredData.count];
    [_filteredData addArray :filteredData];
    [_tableView beginUpdates];
    [_tableView insertSections :indexes withRowAnimation :UITableViewRowAnimationAutomatic];
    [_tableView endUpdates];
}

- (void)addItem :(id)item {
    [_data addObject :item];
    [self filterDataAndReload];
}

- (void)insertItem :(id)item :(int)index {
    [_data insertObject :item atIndex :(uint)index];
    [self filterDataAndReload];
}

- (void)removeItem :(id)item {
    [_data removeObject :item];
    [self filterDataAndReload];
}

- (void)removeItemAtIndex :(NSUInteger)index {
    [_data removeObjectAtIndex :index];
    [self filterDataAndReload];
}

- (id)dataFor :(NSIndexPath *)path {
    return _filteredData[path.index];
}

- (NSArray *)data {
    return _filteredData;
}

- (NSAttributedString *)titleForEmptyDataSet :(UIScrollView *)scrollView {
    if (self.emptyText)
        return [self.emptyText attributed :@{
                NSFontAttributeName: [UIFont preferredFontForTextStyle :UIFontTextStyleHeadline],
                NSForegroundColorAttributeName: [UIColor colorWithContrastingBlackOrWhiteColorOn :_tableView.backgroundColor isFlat :YES]
        }];
    return nil;
}

- (NSAttributedString *)descriptionForEmptyDataSet :(UIScrollView *)scrollView {
    if (self.emptyDescription) {
        NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
        paragraph.alignment = NSTextAlignmentCenter;
        return [self.emptyDescription attributed :@{
                NSFontAttributeName: [UIFont preferredFontForTextStyle :UIFontTextStyleSubheadline],
                NSForegroundColorAttributeName: FlatWhiteDark,
                NSParagraphStyleAttributeName: paragraph
        }];
    }
    return nil;
}

- (CAAnimation *)imageAnimationForEmptyDataSet :(UIScrollView *)scrollView {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath :@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D :CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D :CATransform3DMakeRotation((CGFloat)M_PI_2, 0.0, 0.0, 1.0)];
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = 4;
    return animation;
}

- (UIImage *)imageForEmptyDataSet :(UIScrollView *)scrollView {
    return self.reloadImage.template;
}

- (UIColor *)imageTintColorForEmptyDataSet :(UIScrollView *)scrollView {
    return [UIColor colorWithContrastingBlackOrWhiteColorOn :_tableView.backgroundColor isFlat :YES];
}

- (BOOL)emptyDataSetShouldAnimateImageView :(UIScrollView *)scrollView {
    return YES;
}

- (UIColor *)backgroundColorForEmptyDataSet :(UIScrollView *)scrollView {
    return [UIColor clearColor];
}

- (void)emptyDataSet :(UIScrollView *)scrollView didTapView :(UIView *)view {
    [self reload];
}

- (void)emptyDataSet :(UIScrollView *)scrollView didTapButton :(UIButton *)button {
    [self reload];
}

- (CGFloat)verticalOffsetForEmptyDataSet :(UIScrollView *)scrollView {
    return 100;
}

- (NSString *)emptyText {
    if (_failed) return _failedMessage ? _failedMessage : @"Loading of list content was not successful, click to try again";
    return _emptyText ? _emptyText : @"No items in list to display at this time";
}

- (void)filterDataAndReload {
    [_filteredData reload :[self filterData :_data]];
    [_tableView reloadData];
    if ([_filter respondsToSelector :@selector(onReloadDone:)]) [_filter onReloadDone :self];
}

- (void)clearData {
    _data.removeAllObjects;
    _filteredData.removeAllObjects;
}

@end
