//
// Created by Rene Dohan on 5/28/13.
// Copyright (c) 2013 creative_studio. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//

@import Foundation;

@interface NSLocale (CSExtension)
+ (BOOL)isMetric;

+ (NSNumber *)toCelsius:(NSNumber *)fahrenheit;

+ (NSNumber *)toFahrenheit:(NSNumber *)celsius;

+ (NSNumber *)fromCelsiusToLocale:(NSNumber *)celsius;

+ (NSNumber *)fromFahrenheitToLocale:(NSNumber *)fahrenheit;
@end