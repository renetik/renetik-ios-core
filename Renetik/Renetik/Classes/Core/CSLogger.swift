//
//  CSLogger.swift
//  Renetik
//
//  Created by Rene Dohan on 2/10/19.
//

import Foundation

@objc public protocol CSLogger {
    func logDebug(_ value: String)
    func logInfo(_ value: String)
    func logWarn(_ value: String)
    func logError(_ value: String)
}

public extension UIViewController {
    public func logInfoToast<Subject>(_ value: Subject? = nil, functionName: String = #function,
                                      fileName: String = #file, lineNumber: Int = #line) {
        let className = (fileName as NSString).lastPathComponent
        logger.logInfo("<\(className)> \(functionName) [#\(lineNumber)]| \(stringify(value))")
        toast(stringify(value))
    }
}

public func logDebug<Subject>(_ value: Subject? = nil, functionName: String = #function,
                              fileName: String = #file, lineNumber: Int = #line) {
    let className = (fileName as NSString).lastPathComponent
    let message = "<\(className)> \(functionName) [#\(lineNumber)]| \(String(describing: value))"
    logger.logDebug(message)
    CSNotification(message).bottom().show()
}

public func logInfo(functionName: String = #function,
                    fileName: String = #file, lineNumber: Int = #line) {
    logInfo("", functionName: functionName, fileName: fileName, lineNumber: lineNumber)
}

public func logInfo<Subject>(_ value: Subject? = nil, functionName: String = #function,
                             fileName: String = #file, lineNumber: Int = #line) {
    let className = (fileName as NSString).lastPathComponent
    logger.logInfo("<\(className)> \(functionName) [#\(lineNumber)]| \(stringify(value))")
}

public func logWarn<Subject>(_ value: Subject? = nil, functionName: String = #function,
                             fileName: String = #file, lineNumber: Int = #line) {
    let className = (fileName as NSString).lastPathComponent
    logger.logWarn("<\(className)> \(functionName) [#\(lineNumber)]| \(stringify(value))")
}

public func logError<Subject>(_ value: Subject? = nil, functionName: String = #function,
                              fileName: String = #file, lineNumber: Int = #line) {
    let className = (fileName as NSString).lastPathComponent
    logger.logError("<\(className)> \(functionName) [#\(lineNumber)]| \(stringify(value))")
}
