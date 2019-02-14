//
// Created by Rene Dohan on 30/11/14.
// Copyright (c) 2014 creative_studio. All rights reserved.
//

#import "MKMapItem+CSExtension.h"


@implementation MKMapItem (CSExtension)

+ (void)navigateModeDriving:(CLLocationCoordinate2D)coordinate2D :(NSString *)address {
    MKMapItem *destinationMapItem = [MKMapItem.alloc initWithPlacemark:[MKPlacemark.alloc initWithCoordinate:coordinate2D addressDictionary:nil]];
    destinationMapItem.name = address;
    [MKMapItem openMapsWithItems:@[destinationMapItem] launchOptions:@{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving}];
}

@end