//
// Created by Rene Dohan on 18/05/22.
//

import Foundation

extension NSException {
    public convenience init(reason: String) {
        self.init(name: .genericException, reason: reason, userInfo: nil)
    }
}