//
// Created by Rene Dohan on 2019-01-17.
//

import CocoaLumberjack

public class CocoaLumberjackCSLogger: NSObject, CSLoggerProtocol {

    var isDisabled: Bool = false
    var isToast: Bool = false

    public init(disabled: Bool = false) {
        isDisabled = disabled
    }

    public init(toast: Bool = false) {
        isToast = toast
    }

    public func logDebug(_ value: String) {
        if !isDisabled {
            DDLogDebug(value)
            if isToast { CSNotification().title(value).time(5).show() }
        }
    }

    public func logInfo(_ value: String) {
        if !isDisabled {
            DDLogInfo(value)
            if isToast { CSNotification().title(value).time(5).show() }
        }
    }

    public func logWarn(_ value: String) {
        if !isDisabled {
            DDLogWarn(value)
            if isToast { CSNotification().title(value).time(5).show() }
        }
    }

    public func logError(_ value: String) {
        if !isDisabled {
            DDLogError(value)
            if isToast { CSNotification().title(value).time(5).show() }
        }
    }
}

public class CSCocoaLumberjackFormatter: NSObject, DDLogFormatter {
    var loggerCount = 0
    let threadUnsafeDateFormatter = DateFormatter().also {
        $0.formatterBehavior = .behavior10_4
        $0.dateFormat = "HH:mm:ss:SSS"
    }

    public func format(message: DDLogMessage) -> String? {
        var logLevel: String
        switch message.flag {
        case DDLogFlag.debug: logLevel = "Debug"
        case DDLogFlag.error: logLevel = "Error"
        case DDLogFlag.warning: logLevel = "Warning"
        case DDLogFlag.info: logLevel = "Info"
        default: logLevel = "Verbose"
        }
        var dateAndTime = threadUnsafeDateFormatter.string(from: message.timestamp)
        return "\(dateAndTime) \(logLevel) \(message.fileName ?? "") \(message.function) \(message.line) = \(message.message)"
    }

    public func didAdd(to logger: DDLogger) {
        loggerCount += 1
        assert(loggerCount <= 1, "This logger isn't thread-safe")
    }

    public func willRemove(from logger: DDLogger) { loggerCount -= 1 }
}
