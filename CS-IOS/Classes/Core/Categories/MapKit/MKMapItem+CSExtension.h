//
// Created by Rene Dohan on 30/11/14.
// Copyright (c) 2014 creative_studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MKMapItem (CSExtension)

+ (void)navigateModeDriving:(CLLocationCoordinate2D)coordinate2D :(NSString *)address;

@end