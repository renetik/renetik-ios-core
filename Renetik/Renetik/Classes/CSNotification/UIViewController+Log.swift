import Renetik

public extension UIViewController {
    public func logInfoToast<Subject>(_ value: Subject, functionName: String = #function,
                                      fileName: String = #file, lineNumber: Int = #line) {
        let className = fileName.asNSString.lastPathComponent
        logger.logInfo("<\(className)> \(functionName) [#\(lineNumber)]| \(describe(value))")
        toast(describe(value))
    }
}