//
// Created by Rene Dohan on 2019-01-17.
//

import CocoaLumberjack
import Foundation

// public func logDebug(_ string: String?) { DDLogDebug("\(string)") }

// public func logInfo(_ string: String?) { DDLogInfo("\(string)") }

// public func logWarn(_ string: String?) { DDLogWarn("\(string)") }

public func logDebug<Subject>(_ value: Subject) { DDLogDebug(String(describing: value)) }
public func logInfo<Subject>(_ value: Subject) { DDLogInfo(String(describing: value)) }
public func logWarn<Subject>(_ value: Subject) { DDLogWarn(String(describing: value)) }
public func logError<Subject>(_ value: Subject) { DDLogError(String(describing: value)) }
