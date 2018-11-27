//
// Created by Rene Dohan on 14/06/17.
// Copyright (c) 2017 renetik_software. All rights reserved.
//

#import "CLPlacemark+CSExtension.h"


@implementation CLPlacemark (CSExtension)

- (NSString *)street {
    return self.addressDictionary[@"Street"];
}

- (NSString *)state {
    return self.addressDictionary[@"State"];
}

- (NSString *)city {
    return self.addressDictionary[@"City"];
}

- (NSString *)zip {
    return self.addressDictionary[@"ZIP"];
}

- (NSString *)countryCode {
    return self.addressDictionary[@"CountryCode"];
}

@end