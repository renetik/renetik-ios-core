//
// Created by Rene Dohan on 1/2/20.
//

import RenetikObjc

extension CSTableController {
    @discardableResult
    public func scrollToBottom() -> Self {
        if filteredData.hasItems {
            Renetik.doLater {
                let path = IndexPath(row: self.dataCount - 1, section: 0)
                self.tableView.scrollToRow(at: path, at: .bottom, animated: true)
            }
        }
        return self
    }

    public func isAtBottom() -> Bool {
        let lastPath = tableView.indexPathsForVisibleRows?.last
        if lastPath == nil { return true }
        if lastPath!.row == dataCount - 1 { return true }
        return false
    }
}