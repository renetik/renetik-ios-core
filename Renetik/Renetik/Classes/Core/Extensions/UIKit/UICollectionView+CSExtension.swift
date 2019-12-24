//
// Created by Rene on 2018-11-29.
//

import UIKit

@objc public extension UICollectionView {

    @discardableResult
    @nonobjc public func register<CellType: UICollectionViewCell>(cellType: CellType.Type) -> Self {
        register(cellType, forCellWithReuseIdentifier: cellType.className())
        return self
    }

    @nonobjc public func dequeue<CellType: UICollectionViewCell>(
            cellType: CellType.Type, _ path: IndexPath, onCreate: ((CellType) -> Void)? = nil) -> CellType {
        var cell = dequeueReusableCell(withReuseIdentifier: cellType.className(), for: path) as! CellType
        if cell.contentView.isEmpty() {
            cell.contentView.matchParent()
            cell.construct()
            onCreate?(cell)
        }
        return cell
    }

    public func scrollToPage() {
        var currentCellOffset = contentOffset
        currentCellOffset.x += width / 2
        var path = indexPathForItem(at: currentCellOffset)
        if path.isNil {
            currentCellOffset.x += 15
            path = indexPathForItem(at: currentCellOffset)
        }
        if path != nil {
            logInfo("Scrolling to page \(path!)")
            scrollToItem(at: path!, at: .centeredHorizontally, animated: true)
        }
    }
}
