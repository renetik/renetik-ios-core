//
// Created by Rene Dohan on 18/12/13.
// Copyright (c) 2013 creative_studio. All rights reserved.
//


#import "NSDate+CSExtension.h"


@implementation NSDate (CSExtension)

- (NSDate *)addYear:(int)years {
    NSDateComponents *dateComponents = NSDateComponents.new;
    dateComponents.year = years;
    return [NSCalendar.currentCalendar dateByAddingComponents:dateComponents toDate:self options:0];
}

//- (NSInteger)seconds {
//    return [NSCalendar.currentCalendar components:(NSCalendarUnitSecond) fromDate:NSDate.date].second;
//}
//
//- (NSInteger)minutes {
//    return [NSCalendar.currentCalendar components:(NSCalendarUnitMinute) fromDate:NSDate.date].minute;
//}
//
//- (NSInteger)hour {
//    return [NSCalendar.currentCalendar components:(NSCalendarUnitHour) fromDate:NSDate.date].second;
//}

@end