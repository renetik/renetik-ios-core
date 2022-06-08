//
// Created by inno on 1/20/13.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>
#import "CLGeocoder+CSExtension.h"
#import "CLLocation+CSExtension.h"
#import "CSLang.h"


@implementation CLGeocoder (CSExtension)

- (CLGeocoder *)addressFromLocation:(CLLocation *)location :(BOOL)addCountryName :(void (^)(NSString *))onAddressReady {
    [self reverseGeocodeLocation:location completionHandler:^(NSArray *placemark, NSError *error) {
        runWith(onAddressReady, ABCreateStringWithAddressDictionary([placemark[0] addressDictionary], addCountryName));
    }];
    return self;
}

- (CLGeocoder *)locationFromAddress:(NSString *)address :(void (^)(CLLocation *))onLocationReady {
    [self geocodeAddressString:address completionHandler:^(NSArray *placemark, NSError *error) {
        runWith(onLocationReady, [(CLPlacemark *) placemark[0] location]);
    }];
    return self;
}

- (CLGeocoder *)addressFromCoordinate:(CLLocationCoordinate2D)coordinate :(BOOL)addCountryName :(void (^)(NSString *))onAddressReady {
    [self reverseGeocodeLocation:[CLLocation from:coordinate] completionHandler:^(NSArray *placemark, NSError *error) {
        runWith(onAddressReady, ABCreateStringWithAddressDictionary([placemark[0] addressDictionary], addCountryName));
    }];
    return self;
}

@end