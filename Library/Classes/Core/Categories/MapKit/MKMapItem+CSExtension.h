//
// Created by Rene Dohan on 30/11/14.
// Copyright (c) 2014 creative_studio. All rights reserved.
//

@import UIKit;
@import MapKit;

@interface MKMapItem (CSExtension)

+ (void)navigateModeDriving:(CLLocationCoordinate2D)coordinate2D :(NSString *)address;

@end