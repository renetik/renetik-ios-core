#import "CSAutoCompletionTableView.h"
#import "BlocksKit+UIKit.h"
#import "UITableView+CSExtension.h"
#import "UIView+CSExtension.h"
#import "NSIndexPath+CSExtension.h"

@interface CSAutoCompletionTableView ()
@property(nonatomic, strong) NSArray *suggestionOptions;
@property(nonatomic, strong) UITextField *textField;
@property(nonatomic, strong) UIFont *cellLabelFont;
@end

@implementation CSAutoCompletionTableView

- (instancetype)initWithField:(UITextField *)textField :(UIViewController *)parentController :(NSArray<NSString *> *)suggestions :(NSDictionary *)options {
    self = [super initWithFrame:CGRectMake(textField.frame.origin.x, textField.frame.origin.y + textField.frame.size.height, textField.frame.size.width, 120) style:UITableViewStylePlain];
    if (!self) return nil;
    _suggestions = suggestions;
    _options = options;
    _cellLabelFont = textField.font;
    _textField = textField;
    _textField.autocorrectionType = UITextAutocorrectionTypeNo;
    [_textField bk_addEventHandler:^(id sender) {[self textFieldValueChanged];} forControlEvents:UIControlEventEditingChanged];
    self.delegate = self;
    self.dataSource = self;
    self.scrollEnabled = YES;
    [parentController.view addSubview:[self.hideEmptyCellSplitterBySettingEmptyFooter hide]];
    return self;
}

- (instancetype)initWithField:(UITextField *)textField :(UIViewController *)parentController :(NSArray<NSString *> *)suggestions {
    return [self initWithField:textField :parentController :suggestions :nil];
}


- (BOOL)substringIsInDictionary:(NSString *)subString {
    NSMutableArray *tmpArray = NSMutableArray.array;
    NSRange range;
    if (_autoCompleteDelegate && [_autoCompleteDelegate respondsToSelector:@selector(autoCompletion:suggestionsFor:)])
        _suggestions = [_autoCompleteDelegate autoCompletion:self suggestionsFor:subString];
    for (NSString *tmpString in _suggestions) {
        range = ([[self.options valueForKey:ACOCaseSensitive] isEqualToNumber:@1]) ? [tmpString rangeOfString:subString] : [tmpString rangeOfString:subString options:NSCaseInsensitiveSearch];
        if (range.location != NSNotFound) [tmpArray addObject:tmpString];
    }
    if ([tmpArray count] > 0) {
        self.suggestionOptions = tmpArray;
        return YES;
    }
    return NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.suggestionOptions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *AutoCompleteRowIdentifier = @"AutoCompleteRowIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AutoCompleteRowIdentifier];
    if (cell == nil) cell = [UITableViewCell.alloc initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AutoCompleteRowIdentifier];
    if ([self.options valueForKey:ACOUseSourceFont]) cell.textLabel.font = [self.options valueForKey:ACOUseSourceFont];
    else cell.textLabel.font = self.cellLabelFont;
    cell.textLabel.adjustsFontSizeToFitWidth = NO;
    cell.textLabel.text = self.suggestionOptions[indexPath.index];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.textField setText:self.suggestionOptions[indexPath.index]];
    if (_autoCompleteDelegate && [_autoCompleteDelegate respondsToSelector:@selector(autoCompletion:didSelectAutoCompleteSuggestionWithIndex:)])
        [_autoCompleteDelegate autoCompletion:self didSelectAutoCompleteSuggestionWithIndex:indexPath.row];
    [self hide];
}

- (void)textFieldValueChanged {
    NSString *curString = _textField.text;
    if (![curString length]) {
        [self hide];
        return;
    } else if ([self substringIsInDictionary:curString]) {
        [self show];
        [self reloadData];
    } else [self hide];
}

@end
