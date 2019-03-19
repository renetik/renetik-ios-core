//
//  Created by Rene Dohan on 1/13/13.
//
#import "NSObject+CSExtension.h"
#import "UIImageView+CSExtension.h"
#import "UIView+CSExtension.h"
#import "CSLang.h"

@implementation UIImageView (CSExtension)

- (instancetype)construct {
    super.construct;
	self.aspectFit;
	self.clipsToBounds = true;
    return self;
}

- (void)resizableImageWithCapInsets :(UIEdgeInsets)insets {
    self.image = [self.image resizableImageWithCapInsets :insets];
}

- (instancetype)image :(UIImage *)image {
    self.image = image;
    return self;
}

- (void)stretchableImageWithLeftCapWidth :(NSInteger)leftCapWidth topCapHeight :(NSInteger)topCapHeight {
    self.image = [self.image stretchableImageWithLeftCapWidth :leftCapWidth topCapHeight :topCapHeight];
}

- (instancetype)roundImageCorners :(NSInteger)radius {
    if (!self.image) return self;
    let boundsScale = self.bounds.size.width / self.bounds.size.height;
    let imageScale = self.image.size.width / self.image.size.height;
    var drawingRect = self.bounds;
    if (boundsScale > imageScale) {
        drawingRect.size.width =  drawingRect.size.height * imageScale;
        drawingRect.origin.x = (self.bounds.size.width - drawingRect.size.width) / 2;
    } else {
        drawingRect.size.height = drawingRect.size.width / imageScale;
        drawingRect.origin.y = (self.bounds.size.height - drawingRect.size.height) / 2;
    }
    let path = [UIBezierPath bezierPathWithRoundedRect :drawingRect cornerRadius :radius];
    let mask = CAShapeLayer.new;
    mask.path = path.CGPath;
    self.layer.mask = mask;
    self.layer.masksToBounds = true;
    self.clipsToBounds = YES;
    return self;
}

@end
