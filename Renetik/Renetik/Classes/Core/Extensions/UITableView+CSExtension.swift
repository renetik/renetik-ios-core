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
        _ viewClass: ViewType.Type, _ onCreate: @escaping (UITableViewCell, ViewType) -> Void,
        _ onLoad: @escaping (ViewType) -> Void) -> UITableViewCell {
        var cell = dequeueReusableCell(viewClass.className())
        if cell.isNil {
            cell = UITableViewCell(style: .default, reuseIdentifier: viewClass.className())
            let view = viewClass.init()
            cell!.contentView.matchParent()
            rowHeight = cell!.contentView.content(view.construct()).height
            cell!.width(width, height: rowHeight)
            onCreate(cell!, view.matchParent())
        }
        onLoad(cell!.cellView as! ViewType)
        return cell!
    }
}
