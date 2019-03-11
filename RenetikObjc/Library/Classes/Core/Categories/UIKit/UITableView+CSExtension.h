//
//  Created by Rene Dohan on 6/11/12.
//
@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (CSExtension)

- (instancetype)setupTable :(id <UITableViewDelegate, UITableViewDataSource>)parent;

- (instancetype)setupTable :(id <UITableViewDelegate>)delegate :(id <UITableViewDataSource>)dataSource;

- (UIView *)setHeader :(UIView *)view;

- (UIView *)setFooter :(UIView *)view;

- (void)deselectSelectedRow;

- (void)deselectSelectedRows :(BOOL)animated;

- (nullable UITableViewCell *)dequeueReusableCell :(NSString *)identifier;

- (instancetype)hideEmptyCellSplitterBySettingEmptyFooter;

- (instancetype)toggleEditingAnimated :(BOOL)animated;

- (instancetype)toggleEditing;

- (UITableViewCell *)cellView :(Class)viewClass :(void (^)(UITableViewCell *))onCreate;

- (UITableViewCell *)getCellWithStyle :(NSString *)string :(UITableViewCellStyle)style;

- (UITableViewCell *)getCellWithStyle :(NSString *const)id :(enum UITableViewCellStyle)style :(void (^)(UITableViewCell *cell))onCreate;
@end

NS_ASSUME_NONNULL_END
