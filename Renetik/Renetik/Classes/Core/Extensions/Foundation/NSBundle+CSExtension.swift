//
// Created by Rene Dohan on 9/26/19.
//

import Foundation

public extension Bundle {

    public class var shortVersion: String {
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
        return version ?? ""
    }

    public class var build: String {
        let build = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
        return build ?? ""
    }
}
