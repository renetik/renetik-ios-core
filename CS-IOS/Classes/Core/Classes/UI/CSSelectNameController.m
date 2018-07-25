//
// Created by Rene Dohan on 26/05/18.
// Copyright (c) 2018 Renetik Software. All rights reserved.
//

#import "CSSelectNameController.h"
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
    [self constructByNames:names :onSelected];
    [self menuItem:clearTitle :^(CSMenuItem *item) {[self onClearClick];}];
    return self;
}

- (instancetype)constructByStrings:(NSArray<NSString *> *)strings :(void (^)(NSNumber *))onSelected :(NSString *)clearTitle {
    [self constructByNames:[CSName createNamesFromStrings:strings] :^(CSName *name) {
        runWith(onSelected, name ? @(name.index) : nil);
    } :clearTitle];
    return self;
}

- (instancetype)constructByNames:(NSArray<CSName *> *)names :(void (^)(CSName *))onSelected :(void (^)(CSName *))onDelete :(NSString *)deleteTitle {
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
    _table.allowsSelection = !_onDelete;
    [CSSearchBarController.new construct:(self) :_search :^(NSString *searchText) {[self onFilterData:searchText];}];
    _search.tintColor = self.secondaryColor;
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
    _filteredData = [_names filterBySearch:searchText];
    [_table reloadData];
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
        let delete = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:_deleteTitle handler
        :^(UITableViewRowAction *action, NSIndexPath *indexPath) {[self onDeleteAction:path];}];
        delete.backgroundColor = self.primaryColor;
        return @[delete];
    }
    return nil;
}

- (void)onDeleteAction:(NSIndexPath *)path {
    runWith(_onDelete, [_filteredData at:path.index]);
    [_table reloadData];
}
@end