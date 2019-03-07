//
//  Created by Rene Dohan on 10/14/12.
//

#import "UIImage+CSExtension.h"
#import "CSLang.h"

@implementation UIImage (CSExtension)

- (UIImage *)scaleAndRotateFromCamera :(int)maxResolution {
    CGImageRef imgRef = self.CGImage;
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    CGAffineTransform transform;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > maxResolution || height > maxResolution) {
        CGFloat ratio = width / height;
        if (ratio > 1) {
            bounds.size.width = maxResolution;
            bounds.size.height = roundf(bounds.size.width / ratio);
        } else {
            bounds.size.height = maxResolution;
            bounds.size.width = roundf(bounds.size.height * ratio);
        }
    }

    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = self.imageOrientation;
    switch (orient) {
        case UIImageOrientationUp : //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;

        case UIImageOrientationUpMirrored : //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0f, 1.0);
            break;

        case UIImageOrientationDown : //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;

        case UIImageOrientationDownMirrored : //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0f);
            break;

        case UIImageOrientationLeftMirrored : //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0f, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;

        case UIImageOrientationLeft : //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;

        case UIImageOrientationRightMirrored : //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0f, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;

        case UIImageOrientationRight : //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;

        default :
            [NSException raise :NSInternalInconsistencyException format :@"Invalid image orientation"];
    }

    UIGraphicsBeginImageContext(bounds.size);

    CGContextRef context = UIGraphicsGetCurrentContext();

    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    } else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }

    CGContextConcatCTM(context, transform);

    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return imageCopy;
}

- (UIImage *)scaleToWidth :(float)width {
    float oldWidth = self.size.width;
    float scaleFactor = width / oldWidth;
    float newHeight = self.size.height * scaleFactor;
    float newWidth = oldWidth * scaleFactor;
    return [self getImage :newHeight newWidth :newWidth];
}

- (UIImage *)getImage :(float)newHeight newWidth :(float)newWidth {
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
    [self drawInRect :CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)scaleToHeight :(float)height {
    float oldHeight = self.size.height;
    float scaleFactor = height / oldHeight;
    float newWidth = self.size.width * scaleFactor;
    float newHeight = oldHeight * scaleFactor;
    return [self getImage :newHeight newWidth :newWidth];
}

+ (UIImage *)imageWithColor :(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)inverseColor {
    CIImage *coreImage = [CIImage imageWithCGImage :self.CGImage];
    CIFilter *filter = [CIFilter filterWithName :@"CIColorInvert"];
    [filter setValue :coreImage forKey :kCIInputImageKey];
    CIImage *result = [filter valueForKey :kCIOutputImageKey];
    return [UIImage imageWithCIImage :result];
}

- (UIImage *)template {
    return [self imageWithRenderingMode :UIImageRenderingModeAlwaysTemplate];
}

@end
