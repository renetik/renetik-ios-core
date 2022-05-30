//
// Created by Rene Dohan on 12/11/20.
//

import Foundation

extension TimeInterval {
    public static let QuarterSecond: TimeInterval = HalfSecond / 2
    public static let HalfSecond: TimeInterval = Second / 2
    public static let Second: TimeInterval = 1
    public static let HalfMinute: TimeInterval = 30 * Second
    public static let Minute: TimeInterval = 2 * HalfMinute
    public static let HalfHour: TimeInterval = 30 * Minute
    public static let Hour: TimeInterval = 2 * HalfHour
    public static let Day: TimeInterval = 24 * Hour
}

extension Int {
    public static let KB = 1024
    public static let MB = 1024 * KB
    public static let GB = 1024 * MB
}