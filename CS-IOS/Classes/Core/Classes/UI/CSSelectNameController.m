//
// Created by Rene Dohan on 26/05/18.
// Copyright (c) 2018 Renetik Software. All rights reserved.
//

#import "CSSelectNameController.h"
#import "ChameleonMacros.h"
#import "CSMenuItem.h"
#import "CSSearchBarController.h"

@interface CSSelectNameController () <UITableViewDelegate, UITableViewDataSource>
@end

@implementation CSSelectNameController {
    NSArray<CSName *> *_names;
    NSArray<CSName *> *_filteredData;

    void (^_onSelected)(CSName *);

    void (^_onDelete)(CSName *);

    NSString *_deleteTitle;
}

- (instancetype)constructByNames:(NSArray<CSName *> *)names :(void (^)(CSName *))onSelected {
    [super construct];
    _names = names;
    _onSelected = [onSelected copy];
    _filteredData = [NSArray arrayWithArray:_names];
    return self;
}

- (instancetype)constructByNames:(NSArray<CSName *> *)names :(void (^)(CSName *))onSelected :(NSString *)clearTitle {
    [super construct];
    _names = names;
    _onSelected = [onSelected copy];
    _filteredData = [NSArray arrayWithArray:_names];
    [self menuItem:clearTitle :^(CSMenuItem *item) {[self onClearClick];}];
    return self;
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

- (instancetype)constructByNames:(NSArray<CSName *> *)names :(void (^)(CSName *))onSelected :(void (^)(CSName *))onDelete :(NSString *)deleteTitle {
    [self constructByNames:names :onSelected];
    _onDelete = [onDelete copy];
    _deleteTitle = deleteTitle;
    [[self menuItem:nil type:UIBarButtonSystemItemEdit] onClick:^(CSMenuItem *item) {
        [_table setEditing:!_table.editing animated:YES];
        item.systemItem = _table.editing ? UIBarButtonSystemItemCancel : UIBarButtonSystemItemEdit;
    }];
    return self;
}

- (void)loadView {
    self.view = _table = [UITableView createEmptyWithSize:100 :100].autoResizingWidthHeight;
    _table.tableHeaderView = _search = [UISearchBar createEmptyWithSize:100 :40];
    [_table hideEmptyCellSplitterBySettingEmptyFooter];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [_table setup:self];
    [CSSearchBarController.new construct:(self) :_search :^(NSString *searchText) {[self onFilterData:searchText];}];
    [_table reloadData];
    _table.allowsMultipleSelectionDuringEditing = NO;
}

- (void)onFilterData:(NSString *)searchText {
    _filteredData = [_names filterBySearch:searchText];
    [_table reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)path {
    UITableViewCell *cell = [tableView getCellWithStyle:@"Cell" :UITableViewCellStyleDefault];
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
        let delete = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:_deleteTitle handler
        :^(UITableViewRowAction *action, NSIndexPath *indexPath) {[self onDeleteAction:path];}];
        delete.backgroundColor = FlatRed;
        return @[delete];
    }
    return nil;
}

- (void)onDeleteAction:(NSIndexPath *)path {
    runWith(_onDelete, [_filteredData at:path.index]);
    [_table reloadData];
}
@end