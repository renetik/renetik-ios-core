//
// Created by inno on 1/28/13.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import "UIButton+AFNetworking.h"

@implementation UIButton (CSAFNetworking)


- (void)setImageWithURL:(NSURL *)url {
    [self setImageForState:UIControlStateNormal withURL:url];
}

- (void)setBackgroundImageWithURL:(NSURL *)url {
    [self setBackgroundImageForState:UIControlStateNormal withURL:url];
}


@end