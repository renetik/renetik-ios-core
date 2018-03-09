//
//  Created by Rene Dohan on 10/22/12.
//


#import <Foundation/Foundation.h>

@interface UIPickerView (CSExtension)

- (void)selectRow:(NSUInteger)row;

- (UILabel *)createCenteredLabel:(NSString *)text height:(int)height;

- (UILabel *)createCenteredLabelWithHeight:(int)height;
@end