//
// Created by Rene on 2018-11-29.
//

import UIKit

@objc public extension UITableView {
    @objc public func reloadKeepSelection() {
        let paths = indexPathsForSelectedRows
        reloadData()
        paths?.forEach { (path: IndexPath?) -> Void in
            selectRow(at: path, animated: false, scrollPosition: .none)
        }
    }
}
