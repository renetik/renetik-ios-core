//
//  Created by Rene Dohan on 6/11/12.
//


#import <Foundation/Foundation.h>

@interface UITableView (CSExtension)

- (instancetype _Nonnull)setupTable:(id <UITableViewDelegate, UITableViewDataSource>)parent;

- (instancetype _Nonnull)setupTable:(id <UITableViewDelegate>)delegate :(id <UITableViewDataSource>)dataSource;

- (UIView * _Nonnull)setHeader:(UIView * _Nonnull)view;

- (UIView * _Nonnull)setFooter:(UIView * _Nonnull)view;

- (void)deselectSelectedRow;

- (void)deselectSelectedRows:(BOOL)animated;

- (UITableViewCell *_Nonnull)getCell:(Class)clazz;

- (id)dequeueReusableCell:(NSString *)identifier;

- (instancetype _Nonnull)hideEmptyCellSplitterBySettingEmptyFooter;

- (instancetype _Nonnull)toggleEditingAnimated:(BOOL)animated;

- (instancetype _Nonnull)toggleEditing;

- (UITableViewCell *_Nonnull)cellView:(Class)viewClass :(void (^)(UITableViewCell *_Nonnull))onCreate;

- (UITableViewCell *_Nonnull)getCellWithStyle:(NSString *)string :(UITableViewCellStyle)style;

- (UITableViewCell *_Nonnull)getCellWithStyle:(NSString *const)id :(enum UITableViewCellStyle)style :(void (^)(UITableViewCell *_Nonnull cell))onCreate;
@end