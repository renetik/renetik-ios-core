private let DEFAULT_CELL_ID = "emptyCellIdentifier"

public extension UICollectionView {
    @discardableResult
    func delegates(_ parent: UICollectionViewDelegate & UICollectionViewDataSource) -> Self {
        delegate = parent
        dataSource = parent
        return self
    }

    @discardableResult
    func register<CellType: UICollectionViewCell>(cell cellType: CellType.Type) -> Self {
        register(cellType, forCellWithReuseIdentifier: cellType.className())
        return self
    }

    func scrollToPage() {
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

    @discardableResult
    func registerDefaultCell() -> Self {
        register(UICollectionViewCell.self, forCellWithReuseIdentifier: DEFAULT_CELL_ID)
        return self
    }

}
