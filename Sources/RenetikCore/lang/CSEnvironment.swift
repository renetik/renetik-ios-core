public class CSEnvironment {
    public static var isDebug: Bool {
        #if DEBUG
            return true
        #else
            return false
        #endif
    }
    public static var isMac: Bool { tagetEnvironment == .macOS }
    public enum CSTargetEnvironment {
        case iOS
        case macOS
        case watchOS
    }

    public static var tagetEnvironment: CSTargetEnvironment {
        #if targetEnvironment(macCatalyst)
            .macOS
        #elseif os(watchOS)
            .watchOS
        #else
            .iOS
        #endif
    }
    public static var isPreview: Bool { ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" }
}

