//
// Created by inno on 1/20/13.
//
// To change the template use AppCode | Preferences | File Templates.
//

@import Foundation;
@import CoreLocation;

@interface CLGeocoder (CSExtension)

- (CLGeocoder *)addressFromLocation:(CLLocation *)location :(BOOL)addCountryName :(void (^)(NSString *))onAddressReady;

- (CLGeocoder *)locationFromAddress:(NSString *)address :(void (^)(CLLocation *))onLocationReady;

- (CLGeocoder *)addressFromCoordinate:(CLLocationCoordinate2D)coordinate :(BOOL)addCountryName :(void (^)(NSString *))onAddressReady;
@end