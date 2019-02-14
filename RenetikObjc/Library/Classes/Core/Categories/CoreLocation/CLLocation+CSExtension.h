//
// Created by inno on 1/20/13.
//
// To change the template use AppCode | Preferences | File Templates.
//

@import Foundation;
@import CoreLocation;

@interface CLLocation (CSExtension)

+ (CLLocation *)from:(CLLocationCoordinate2D)coordinate2D;

@end