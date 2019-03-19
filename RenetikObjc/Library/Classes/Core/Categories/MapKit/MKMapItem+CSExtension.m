//
// Created by Rene Dohan on 30/11/14.
// Copyright (c) 2014 creative_studio. All rights reserved.
//

#import "MKMapItem+CSExtension.h"
#import "CSLang.h"

@implementation MKMapItem (CSExtension)

+ (void)navigateModeDriving :(double)lat :(double)lng :(NSString *)name {
    let coordinate = CLLocationCoordinate2DMake(lat, lng);
    [MKMapItem navigateModeDriving :coordinate :name];
}

+ (void)navigateModeDriving :(CLLocationCoordinate2D)coordinate
                            :(NSString *)name {
    let destinationMapItem =
        [MKMapItem.alloc initWithPlacemark :
         [MKPlacemark.alloc initWithCoordinate
          :coordinate addressDictionary :nil]];
    destinationMapItem.name = name;
    [MKMapItem openMapsWithItems :@[destinationMapItem] launchOptions :@{ MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving }];
}

@end
