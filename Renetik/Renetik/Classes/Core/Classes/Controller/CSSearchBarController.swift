//
// Created by Rene Dohan on 12/17/19.
//

import UIKit
import RenetikObjc

public class CSSearchBarController: CSMainController, UISearchBarDelegate {

    public let bar = UISearchBar.construct().resizeToFit()
    public var text: String { bar.text ?? "" }

    private var searchBarShouldBeginEditing = false
    private var onTextChanged: ((String) -> Void)!

    @discardableResult
    public func construct(by parent: CSMainController,
            placeHolder: String = CSStrings.searchPlaceholder,
            onTextChanged: @escaping (String) -> Void) -> Self {
        super.constructAsViewLess(in: parent)
        self.onTextChanged = onTextChanged
        bar.delegate = self
        bar.showsCancelButton = false
        bar.placeholder = placeHolder
        return self
    }

    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchBar.isFirstResponder {
            searchBarShouldBeginEditing = false
            searchBar.resignFirstResponder()
        }
        onTextChanged(searchText)
    }

    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    public func searchBarShouldBeginEditing(_ bar: UISearchBar) -> Bool {
        let boolToReturn = searchBarShouldBeginEditing
        searchBarShouldBeginEditing = true
        return boolToReturn
    }

    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        animate { searchBar.showsCancelButton = true }
    }

    public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        animate { searchBar.showsCancelButton = false }
    }
}

public extension CSSearchBarController {

    @discardableResult
    public func construct<Row: CSTableControllerRow, Data>(
            _ parent: CSMainController,
            placeHolder: String = CSStrings.searchPlaceholder,
            table: CSTableController<Row, Data>,
            filter: CSTableFilter<Row, Data> = CSContainsIgnoreCaseTableFilter<Row, Data>()) -> Self {
        table.filter = filter
        construct(by: parent, placeHolder: placeHolder) { string in
            filter.searchText = string
            table.filterDataAndReload()
        }
        return self
    }
}