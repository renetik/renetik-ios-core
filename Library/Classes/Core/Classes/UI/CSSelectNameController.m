//
// Created by Rene Dohan on 26/05/18.
// Copyright (c) 2018 Renetik Software. All rights reserved.
//

#import "CSSelectNameController.h"
#import "CSMenuItem.h"
#import "CSSearchBarController.h"
#import "CSListData.h"
#import "CSResponse.h"

@interface CSSelectNameController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)  NSMutableArray<CSName *> * names;
@end

@implementation CSSelectNameController {
    NSArray<CSName *> *_filteredData;
    void (^_onSelected)(CSName *);
    CSResponse *(^_onDelete)(CSName *);
    NSString *_deleteTitle;
}

- (instancetype)constructByData:(NSObject <CSListData> *)names :(void (^)(CSName *))onSelected {
    return [self constructByNames:names.list :onSelected];
}

- (instancetype)constructByData:(NSObject <CSListData> *)names :(void (^)(CSName *))onSelected
        :(NSString *)deleteTitle :(CSResponse *(^)(CSName *))onDelete {
    [self constructByData:names :onSelected];
    _onDelete = [onDelete copy];
    _deleteTitle = deleteTitle;
    [[self menuItem:nil type:UIBarButtonSystemItemEdit] onClick:^(CSMenuItem *item) {
        item.systemItem = _table.toggleEditing.editing ? UIBarButtonSystemItemCancel : UIBarButtonSystemItemEdit;
    }];
    return self;
}

- (instancetype)constructByNames:(NSArray<CSName *> *)names :(void (^)(CSName *))onSelected {
    _names = names.mutableCopy;
    _onSelected = [onSelected copy];
    _filteredData = [NSArray arrayWithArray:_names];
    return self;
}

- (instancetype)constructByNames:(NSArray<CSName *> *)names :(void (^)(CSName *))onSelected :(NSString *)clearTitle {
    [self constructByNames:names :onSelected];
    wlet _self = self;
    [self menuItem:clearTitle :^(CSMenuItem *item) {[_self onClearClick];}];
    return self;
}

- (instancetype)constructByStrings:(NSArray<NSString *> *)strings :(void (^)(NSNumber *))onSelected :(NSString *)clearTitle {
    [self constructByNames:[CSName createNamesFromStrings:strings] :^(CSName *name) {
        runWith(onSelected, name ? @(name.index) : nil);
    } :clearTitle];
    return self;
}

- (instancetype)constructByNames:(NSArray<CSName *> *)names :(void (^)(CSName *))onSelected
        :(NSString *)deleteTitle :(CSResponse * (^)(CSName *))onDelete {
    [self constructByNames:names :onSelected];
    _onDelete = [onDelete copy];
    _deleteTitle = deleteTitle;
    [[self menuItem:nil type:UIBarButtonSystemItemEdit] onClick:^(CSMenuItem *item) {
        item.systemItem = _table.toggleEditing.editing ? UIBarButtonSystemItemCancel : UIBarButtonSystemItemEdit;
    }];
    return self;
}

- (void)loadView {
    self.view = _table = [UITableView withSize:100 :100];
    _table.tableHeaderView = _search = [UISearchBar withSize:100 :40];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[_table setupTable:self] hideEmptyCellSplitterBySettingEmptyFooter].allowsMultipleSelectionDuringEditing = NO;
    wlet _self = self;
    [CSSearchBarController.new construct:(self) :_search :^(NSString *searchText) {[_self reload];}];
}

- (void)onClearClick {
    [self.navigationController popViewController];
    runWith(_onSelected, _selectedRow = nil);
}

- (instancetype)setData:(NSArray<CSName *> *)names {
    _names = names;
    [_table reloadData];
    return self;
}

- (void)onFilterData:(NSString *)searchText {
    [self reload];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)path {
    UITableViewCell *cell = [tableView getCellWithStyle:@"Cell" :UITableViewCellStyleDefault];
    cell.textLabel.textColor = self.secondaryColor;
    cell.textLabel.text = [_filteredData at:path.index].name;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _filteredData.size;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)path {
    _selectedRow = [_filteredData at:path.index];
    [self.navigationController popViewController];
    runWith(_onSelected, _selectedRow);
}

- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)path {
    if (_onDelete) {
        wlet _self = self;
        let delete = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:_deleteTitle handler
        :^(UITableViewRowAction *action, NSIndexPath *indexPath) {[_self onDeleteAction:path];}];
        delete.backgroundColor = self.primaryColor;
        return @[delete];
    }
    return nil;
}

- (void)onDeleteAction:(NSIndexPath *)path {
    let value = [_filteredData at:path.index];
    wlet _self = self;
    [_onDelete(value) onSuccess:^(id o) {
        [_self.names remove:value];
        [_self reload];
    }];
}

- (void)reload {
    _filteredData = [_names filterBySearch:_search.text];
    [_table reloadData];
}
@end
