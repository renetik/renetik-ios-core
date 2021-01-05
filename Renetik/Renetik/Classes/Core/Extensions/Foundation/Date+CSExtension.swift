//
// Created by Rene Dohan on 1/5/21.
//

import Foundation

public extension Date {
    func add(years: Int) -> Date {
        Calendar.current.date(byAdding: .year, value: years, to: self)!
    }

    func add(days: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: days, to: self)!
    }

    func add(hours: Int) -> Date {
        Calendar.current.date(byAdding: .hour, value: hours, to: self)!
    }
}