//
// Created by Rene on 2018-11-29.
//

import UIKit
import RenetikObjc

public extension UITableView {

    override open func construct() -> Self {
        super.construct()
        return self
    }

    @discardableResult
    public func reloadKeepSelection() -> Self {
        let paths = indexPathsForSelectedRows
        reload()
        paths?.forEach { path in selectRow(at: path, animated: false, scrollPosition: .none) }
        return self
    }

    public func cell(style: UITableViewCell.CellStyle,
                     onCreate: ((UITableViewCell) -> Void)? = nil) -> UITableViewCell {
        cell(with: "Cell", style: style, onCreate: onCreate)
    }

    public func cell(with identifier: String, style: UITableViewCell.CellStyle,
                     onCreate: ((UITableViewCell) -> Void)? = nil) -> UITableViewCell {
        var cell = dequeueCellWith(identifier: identifier)
        if cell.isNil {
            cell = UITableViewCell(style: style, reuseIdentifier: identifier)
            onCreate?(cell!.construct())
        }
        return cell!
    }

    @discardableResult
    public func register<CellType: UITableViewCell>(cell type: CellType.Type) -> Self {
        register(type, forCellReuseIdentifier: type.className())
        return self
    }

    private func dequeue<CellType: UITableViewCell>(cell type: CellType.Type) -> CellType {
        let cell = dequeueCellWith(identifier: type.className()) as? CellType
        return cell.isNil ? register(cell: type).dequeueCellWith(identifier: type.className()) as! CellType : cell!
    }

    public func dequeue<CellType: UITableViewCell>(
            cell type: CellType.Type, onCreate: ((CellType) -> Void)? = nil) -> CellType {
        var cell = dequeue(cell: type)
        if cell.contentView.isEmpty {
            onCreate?(cell)
            cell.contentView.matchParent()
            cell.width(width, height: width)
            cell.construct()
        }
        return cell
    }

    @discardableResult
    public func toggleEditing(animated: Bool = true) -> Self {
        setEditing(!isEditing, animated: animated)
        return self
    }

    /*
    * This triggers table reload !!!
    */
    @discardableResult
    public func hideEmptySeparatorsByEmptyFooter() -> Self {
        tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
        return self
    }

    public func deselectSelectedRow(animated: Bool = true) {
        indexPathForSelectedRow?.also { path in deselectRow(at: path, animated: animated) }
    }

    public func deselectSelectedRows(animated: Bool = true) {
        for path in indexPathsForSelectedRows ?? [] { deselectRow(at: path, animated: animated) }
    }

    public func dequeueCellWith(identifier: String?) -> UITableViewCell? {
        dequeueReusableCell(withIdentifier: identifier ?? "")
    }

    @discardableResult
    public func reload() -> Self {
        reloadData()
        return self
    }

    @discardableResult
    public func set<View: UIView>(header view: View) -> View {
        tableHeaderView = view
        return view
    }

    @discardableResult
    public func set(footer view: UIView?) -> UIView? {
        tableFooterView = view
        return view
    }

    @discardableResult
    public func delegates(_ delegates: UITableViewDelegate & UITableViewDataSource) -> Self {
        self.delegate = delegates
        self.dataSource = delegates
        return self
    }

    @discardableResult
    public func header<View: UIView>(_ view: View) -> View { tableHeaderView = view; return view }

    public var contentHeight: CGFloat {
        let lastFooterRect = rectForFooter(inSection: lastSection)
        return lastFooterRect.origin.y + lastFooterRect.size.height
    }

    public var lastSection: Int {
        var lastSection = numberOfSections - 1
        while lastSection > 0 && numberOfRows(inSection: lastSection) <= 0 {
            lastSection -= 1
        }
        return lastSection
    }
}
