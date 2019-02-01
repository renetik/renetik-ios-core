@import UIKit;

// Consts for AutoCompleteOptions:
// if YES - suggestions will be picked for display case-sensitive
// if NO - case will be ignored
#define ACOCaseSensitive @"ACOCaseSensitive"
// if "nil" each cell will copy the font of the source UITextField
// if not "nil" given UIFont will be used
#define ACOUseSourceFont @"ACOUseSourceFont"

@class CSAutoCompletionTableView;

@protocol AutocompletionTableViewDelegate <NSObject>
@required
- (NSArray *)autoCompletion:(CSAutoCompletionTableView *)completer suggestionsFor:(NSString *)string;

- (void)autoCompletion:(CSAutoCompletionTableView *)completer didSelectAutoCompleteSuggestionWithIndex:(NSInteger)index;
@end

@interface CSAutoCompletionTableView : UITableView <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) NSArray<NSString *> *suggestions;
@property(nonatomic, strong) id <AutocompletionTableViewDelegate> autoCompleteDelegate;
@property(nonatomic, strong) NSDictionary *options;


- (instancetype)initWithField:(UITextField *)textField :(UIViewController *)parentController :(NSArray<NSString *> *)suggestions :(NSDictionary *)options;

- (instancetype)initWithField:(UITextField *)textField :(UIViewController *)parentController :(NSArray<NSString *> *)suggestions;

@end
