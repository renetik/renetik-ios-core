//
// Created by Rene Dohan on 27/03/18.
//

#import "CSMenuIcon.h"

@implementation CSMenuIcon

+ (UIImage *)image {
    static UIImage *drawerButtonImage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(26, 26), NO, 0);
//// Color Declarations
        UIColor *fillColor = [UIColor whiteColor];
//// Frames
        CGRect frame = CGRectMake(0, 0, 26, 26);
//// Bottom Bar Drawing
        UIBezierPath *bottomBarPath = [UIBezierPath bezierPathWithRect:CGRectMake(CGRectGetMinX(frame) + floor((CGRectGetWidth(frame) - 16) * 0.50000 + 0.5), CGRectGetMinY(frame) + floor((CGRectGetHeight(frame) - 1) * 0.72000 + 0.5), 16, 1)];
        [fillColor setFill];
        [bottomBarPath fill];
//// Middle Bar Drawing
        UIBezierPath *middleBarPath = [UIBezierPath bezierPathWithRect:CGRectMake(CGRectGetMinX(frame) + floor((CGRectGetWidth(frame) - 16) * 0.50000 + 0.5), CGRectGetMinY(frame) + floor((CGRectGetHeight(frame) - 1) * 0.48000 + 0.5), 16, 1)];
        [fillColor setFill];
        [middleBarPath fill];
//// Top Bar Drawing
        UIBezierPath *topBarPath = [UIBezierPath bezierPathWithRect:CGRectMake(CGRectGetMinX(frame) + floor((CGRectGetWidth(frame) - 16) * 0.50000 + 0.5), CGRectGetMinY(frame) + floor((CGRectGetHeight(frame) - 1) * 0.24000 + 0.5), 16, 1)];
        [fillColor setFill];
        [topBarPath fill];
        drawerButtonImage = UIGraphicsGetImageFromCurrentImageContext();
    });
    return drawerButtonImage;
}

@end