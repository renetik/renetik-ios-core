//
//  Created by Rene Dohan on 6/11/12.
//


#import <UIKit/UIKit.h>
#import "CSLang.h"
#import "UIView+CSExtension.h"
#import "NSObject+CSExtension.h"
#import "UIViewController+CSExtension.h"
#import "UINavigationController+CSExtension.h"


@implementation UITableView (CSExtension)

- (instancetype)setup:(id <UITableViewDelegate>)delegate :(id <UITableViewDataSource>)dataSource {
    self.delegate = delegate;
    self.dataSource = dataSource;
    return self;
}

- (void)deselectSelectedRow {
    [self deselectRowAtIndexPath:self.indexPathForSelectedRow animated:YES];
}


- (void)deselectSelectedRows:(BOOL)animated {
    for (NSIndexPath *path in self.indexPathsForSelectedRows)
        [self deselectRowAtIndexPath:path animated:animated];
}

- (UITableViewCell *)getCell:(Class)type {
    id object = [self dequeueReusableCell:[type description]];
    if (!object) object = [type create];
    return object;
}

- (id)dequeueReusableCell:(NSString *)identifier {
    return [self dequeueReusableCellWithIdentifier:identifier];
}

- (id)getHeaderFooter:(Class)type {
    id object = [self dequeueReusableHeaderFooter:[type description]];
    if (!object) object = [type create];
    return object;
}

- (id)dequeueReusableHeaderFooter:(NSString *)identifier {
    return [self dequeueReusableHeaderFooterViewWithIdentifier:identifier];
}

- (void)hideEmptyCellSplitterBySettingEmptyFooter {
    [self setTableFooterView:[UIView.alloc initWithFrame:CGRectMake(0, 0, 0, 0.1)]];
}

- (void)toggleEditingAnimated:(BOOL)animated {
    [self setEditing:!self.isEditing animated:animated];
}

- (UITableViewCell *)getCellForView:(Class)viewClass {
    UITableViewCell *cell = [self dequeueReusableCell:[viewClass className]];
    if (!cell)
        cell = [self createCell:viewClass];
    return cell;
}

- (UITableViewCell *)createCellForView:(Class)viewClass :(void (^)(UITableViewCell *))onCreate {
    UITableViewCell *cell = [self dequeueReusableCell:[viewClass className]];
    if (!cell) {
        cell = [self createCell:viewClass];
        invokeWith(onCreate, cell);
    }
    return cell;
}

- (UITableViewCell *)createCell:(Class)viewClass {
    UITableViewCell *cell = [UITableViewCell.alloc initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[viewClass className]];
    UIView *view = [viewClass.create construct];
    cell.size = CGSizeMake(self.width, self.rowHeight = view.height);
    [cell.contentView matchParent];
    [cell.contentView addView:view].matchParent;
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    return cell;
}

- (UITableViewCell *)getCellWithStyle:(NSString *)id :(UITableViewCellStyle)style {
    return [self getCellWithStyle:id :style :nil];
}

- (UITableViewCell *)getCellWithStyle:(NSString *const)id :(enum UITableViewCellStyle)style :(void (^)(UITableViewCell *cell))onCreate {
    UITableViewCell *cell = [self dequeueReusableCell:id];
    if (!cell) runWith(onCreate, cell = [UITableViewCell.alloc initWithStyle:style reuseIdentifier:id]);
    return cell;
}
@end
