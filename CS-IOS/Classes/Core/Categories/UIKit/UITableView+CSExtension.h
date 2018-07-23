//
//  Created by Rene Dohan on 6/11/12.
//


#import <Foundation/Foundation.h>

@interface UITableView (CSExtension)

- (instancetype)setupTable:(id <UITableViewDelegate, UITableViewDataSource>)parent;

- (instancetype)setupTable:(id <UITableViewDelegate>)delegate :(id <UITableViewDataSource>)dataSource;

- (instancetype)setHeader:(UIView *)header;

- (UIView *)setFooter:(UIView *)header;

- (void)deselectSelectedRow;

- (void)deselectSelectedRows:(BOOL)animated;

- (UITableViewCell *)getCell:(Class)clazz;

- (id)dequeueReusableCell:(NSString *)identifier;

- (instancetype)hideEmptyCellSplitterBySettingEmptyFooter;

- (instancetype)toggleEditingAnimated:(BOOL)animated;

- (instancetype)toggleEditing;

- (UITableViewCell *)cellView:(Class)viewClass :(void (^)(UITableViewCell *))onCreate;

- (UITableViewCell *)getCellWithStyle:(NSString *)string :(UITableViewCellStyle)style;

- (UITableViewCell *)getCellWithStyle:(NSString *const)id :(enum UITableViewCellStyle)style :(void (^)(UITableViewCell *cell))onCreate;
@end