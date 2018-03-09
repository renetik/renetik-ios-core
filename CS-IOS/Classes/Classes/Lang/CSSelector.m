//
//  Created by Rene Dohan on 5/14/12.
//


#import "CSSelector.h"
#import "CSLang.h"
#import "CSCocoaLumberjack.h"

@implementation CSSelector {

}
@synthesize selector, object;

+ (CSSelector *)new:(SEL)selector :(NSObject *)object {
    CSSelector *this = [self new];
    this.object = object;
    this.selector = selector;
    return this;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

- (id)run {
    if ([self.object respondsToSelector:self.selector])
        return [self.object performSelector:self.selector];
    error(@"Object expected to contain selector");
    return nil;
}

#pragma clang diagnostic pop

@end
