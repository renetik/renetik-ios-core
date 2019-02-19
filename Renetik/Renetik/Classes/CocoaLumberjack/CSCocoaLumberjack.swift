//
// Created by Rene Dohan on 2019-01-17.
//

import CocoaLumberjack

@objc public class CocoaLumberjackCSLogger: NSObject, CSLogger {
	public func logDebug(_ value: String) {
		DDLogDebug(value)
	}
	
	public func logInfo(_ value: String) {
		DDLogInfo(value)
	}
	
	public func logWarn(_ value: String) {
		DDLogWarn(value)
	}
	
	public func logError(_ value: String) {
		DDLogError(value)
	}
}
