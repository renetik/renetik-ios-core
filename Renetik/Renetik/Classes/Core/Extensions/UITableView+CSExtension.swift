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

    @nonobjc func cellView<ViewType: UIView>(
        _ cellViewType: ViewType.Type,
        onCreate: @escaping (UITableViewCell, ViewType) -> Void,
        onLoad: @escaping (ViewType) -> Void) -> UITableViewCell {
        var cell = dequeueReusableCell(cellViewType.className())
        if cell.isNil {
            cell = UITableViewCell(style: .default,
                                   reuseIdentifier: cellViewType.className())
            cell!.contentView.matchParent()
            let cellView = cellViewType.init()
            onCreate(cell!, cellView)
            cell!.contentView.content(cellView.construct())
            cell!.width(width, height: cellView.height)
            cellView.matchParent()
        }
        onLoad(cell!.cellView as! ViewType)
        return cell!
    }

    @objc func cell(with identifier: String,
                    style: UITableViewCell.CellStyle,
                    onCreate: ((UITableViewCell) -> Void)? = nil)
        -> UITableViewCell {
        var cell = dequeueReusableCell(identifier)
        if cell.isNil {
            cell = UITableViewCell(style: style, reuseIdentifier: identifier)
            onCreate?(cell!.construct())
        }
        return cell!
    }
}
