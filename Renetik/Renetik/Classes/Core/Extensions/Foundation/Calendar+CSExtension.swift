//
// Created by Rene Dohan on 9/23/19.
//

import Foundation

public let calendar = Calendar.current

public extension Calendar {

    func dateFrom(_ year: String?, _ month: String? = nil, _ day: String? = nil) -> Date? {
        let dateComponents = DateComponents(calendar: self,
                year: year?.intValue, month: month?.intValue, day: day?.intValue)
        return calendar.date(from: dateComponents)
    }

}
//
//
//fun Calendar.fromTime(time: Long) =
//        apply { this.timeInMillis = time }
//
//fun Calendar.from(date: Date) =
//        apply { this.time = date }
//
//fun Calendar.from(year: Int, month: Int? = null, day: Int? = null) =
//        apply { set(year, month.asInt(), day.asInt(), 0, 0, 0) }
//
//fun Calendar.from(year: String?, month: String? = null, day: String? = null) =
//        apply { from(year.asInt(), month.asInt(), day.asInt()) }
//
//fun Calendar.dateFrom(year: Int, month: Int? = null, day: Int? = null): Date? {
//    return from(year, month, day).time
//}
//
//fun Calendar.dateFrom(year: String?, month: String? = null, day: String? = null): Date? {
//    if (year == null) return null
//    return dateFrom(year.toInt(), month?.toInt(), day?.toInt())
//}
//
//val Calendar.age: Int
//get() {
//    val today = calendar
//    var age = today[Calendar.YEAR] - this[Calendar.YEAR]
//    if (today[Calendar.DAY_OF_YEAR] < this[Calendar.DAY_OF_YEAR]) age--
//    return age
//}