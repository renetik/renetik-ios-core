//
// Created by Rene Dohan on 1/5/21.
//

import Foundation

public extension Date {
    var day: Int { calendar.component(.day, from: self) }
    var month: Int { calendar.component(.month, from: self) }
    var year: Int { calendar.component(.year, from: self) }

    func add(hours: Int) -> Date { calendar.date(byAdding: .hour, value: hours, to: self)! }

    func add(days: Int) -> Date { calendar.date(byAdding: .day, value: days, to: self)! }

    func add(months: Int) -> Date { calendar.date(byAdding: .month, value: months, to: self)! }

    func add(years: Int) -> Date { calendar.date(byAdding: .year, value: years, to: self)! }
}