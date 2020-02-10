//
// Created by Rene Dohan on 1/2/20.
//

import RenetikObjc

public extension CSTableController {

    @discardableResult
    public func scroll(to row: Row) -> Self {
        scroll(to: data.index(of: row)!)
    }

    @discardableResult
    public func scroll(to index: Int) -> Self {
        tableView.scrollToRow(at: IndexPath(row: index, section: 0), at: .middle, animated: true)
        return self
    }

    @discardableResult
    public func scrollToBottom() -> Self {
        if isLoading || isFirstLoadingDone.isFalse {
            onLoadResponse.invokeOnce { response in response.onDone { _ in self.scrollToBottom() } }
        } else {
            doLater { self.scrollToBottom() }
        }
        return self
    }

    private func scrollToBottom() {
        if self.dataCount > 0 {
            let path = IndexPath(row: self.dataCount - 1, section: 0)
            self.tableView.scrollToRow(at: path, at: .bottom, animated: true)
        }
    }

    public func isAtBottom() -> Bool {
        let lastPath = tableView.indexPathsForVisibleRows?.last
        if lastPath == nil { return true }
        if lastPath!.row == dataCount - 1 { return true }
        return false
    }
}