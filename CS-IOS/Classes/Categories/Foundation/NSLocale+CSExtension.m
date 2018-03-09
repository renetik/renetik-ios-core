//
// Created by Rene Dohan on 5/28/13.
// Copyright (c) 2013 creative_studio. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "NSLocale+CSExtension.h"


@implementation NSLocale (CSExtension)

+ (BOOL)isMetric {
    return [[NSLocale.currentLocale objectForKey:NSLocaleUsesMetricSystem] boolValue];
}

+ (NSNumber *)toCelsius:(NSNumber *)fahrenheit {
    return [NSNumber numberWithInt:(fahrenheit.intValue - 32) / 1.8];
}

+ (NSNumber *)toFahrenheit:(NSNumber *)celsius {
    return [NSNumber numberWithInt:(celsius.intValue * 1.8 + 32)];
}

+ (NSNumber *)fromCelsiusToLocale:(NSNumber *)celsius {
    return (NSLocale.isMetric) ? celsius : ([NSLocale toFahrenheit:celsius]);
}

+ (NSNumber *)fromFahrenheitToLocale:(NSNumber *)fahrenheit {
    return !NSLocale.isMetric ? fahrenheit : ([NSLocale toCelsius:fahrenheit]);
}

@end