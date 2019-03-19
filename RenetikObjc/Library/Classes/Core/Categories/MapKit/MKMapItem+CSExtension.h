//
// Created by Rene Dohan on 30/11/14.
// Copyright (c) 2014 creative_studio. All rights reserved.
//

@import UIKit;
@import MapKit;

@interface MKMapItem (CSExtension)

+ (void)navigateModeDriving :(double)lat :(double)lng :(NSString *)name;
+ (void)navigateModeDriving :(CLLocationCoordinate2D)coordinate :(NSString *)name;

@end
