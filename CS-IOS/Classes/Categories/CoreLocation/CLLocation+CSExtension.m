//
// Created by inno on 1/20/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "CLLocation+CSExtension.h"


@implementation CLLocation (CSExtension)
+ (CLLocation *)from:(CLLocationCoordinate2D)coordinate2D {
    return [[CLLocation alloc] initWithLatitude:coordinate2D.latitude longitude:coordinate2D.longitude];
}

@end