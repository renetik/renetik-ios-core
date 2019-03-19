//
//  Created by Rene Dohan on 6/11/12.
//

#import "CSLang.h"
#import "UIView+CSExtension.h"
#import "NSObject+CSExtension.h"
#import "UIViewController+CSExtension.h"
#import "UINavigationController+CSExtension.h"
#import "UIView+CSDimension.h"

#import "UIView+CSLayout.h"

@implementation UITableView (CSExtension)

- (instancetype)construct {
    super.construct;
    self.backgroundColor = UIColor.clearColor;
    return self;
}

- (instancetype)setupTable :(id <UITableViewDelegate, UITableViewDataSource>)parent {
    self.delegate = parent;
    self.dataSource = parent;
    [self reloadData];
    return self;
}

- (instancetype)setupTable :(id <UITableViewDelegate>)delegate :(id <UITableViewDataSource>)dataSource {
    self.delegate = delegate;
    self.dataSource = dataSource;
    [self reloadData];
    return self;
}

- (UIView *)setHeader :(UIView *)view {
    self.tableHeaderView = view;
    return view;
}

- (UIView *)setFooter :(UIView *)view {
    self.tableFooterView = view;
    return view;
}

- (void)deselectSelectedRow {
    [self deselectRowAtIndexPath :self.indexPathForSelectedRow animated :YES];
}

- (void)deselectSelectedRows :(BOOL)animated {
    for (NSIndexPath *path in self.indexPathsForSelectedRows)
        [self deselectRowAtIndexPath :path animated :animated];
}

- (UITableViewCell *)dequeueReusableCell :(NSString *)identifier {
    return [self dequeueReusableCellWithIdentifier :identifier];
}

- (instancetype)hideEmptyCellSplitterBySettingEmptyFooter {
    [self setTableFooterView :[UIView.alloc initWithFrame :CGRectMake(0, 0, 0, 0.1)]];
    return self;
}

- (instancetype)toggleEditingAnimated :(BOOL)animated {
    [self setEditing :!self.isEditing animated :animated];
    return self;
}

- (instancetype)toggleEditing {
    [self setEditing :!self.isEditing animated :YES];
    return self;
}

- (UITableViewCell *)cellView :(Class)viewClass
                              :(void (^)(UITableViewCell *))onCreate {
    var cell = [self dequeueReusableCell :[viewClass className]];
    if (!cell) invokeWith(onCreate, cell = [self createCell :viewClass]);
    return cell;
}

- (UITableViewCell *)createCell :(Class)viewClass {
    let cell = [UITableViewCell.alloc initWithStyle :UITableViewCellStyleDefault reuseIdentifier :[viewClass className]];
    UIView *view = viewClass.construct;
    [cell size :CGSizeMake(self.width, self.rowHeight = view.height)];
    [cell.contentView matchParent];
    [cell.contentView content :view].matchParent;
    return cell;
}



@end
