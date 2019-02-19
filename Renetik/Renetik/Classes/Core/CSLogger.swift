//
//  CSLogger.swift
//  Renetik
//
//  Created by Rene Dohan on 2/10/19.
//

import Foundation

@objc public protocol CSLogger {
	@objc func logDebug(_ value: String)
	@objc func logInfo(_ value: String)
	@objc func logWarn(_ value: String)
	@objc func logError(_ value: String)
}

public func logDebug<Subject>(_ value: Subject) {
    CSAppDelegate.instance().logger.logDebug(String(describing: value))
}

public func logInfo<Subject>(_ value: Subject) {
    CSAppDelegate.instance().logger.logInfo(String(describing: value))
}

public func logWarn<Subject>(_ value: Subject) {
    CSAppDelegate.instance().logger.logWarn(String(describing: value))
}

public func logError<Subject>(_ value: Subject) {
    CSAppDelegate.instance().logger.logError(String(describing: value))
}
