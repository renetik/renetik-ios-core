//
//  Created by Rene Dohan on 1/12/13.
//

@import UIKit;

@interface UITextView (CSExtension)

- (instancetype)setHTMLFromString :(NSString*)string;

- (instancetype)asLabel;

- (instancetype)sizeFitHeight;
@end
