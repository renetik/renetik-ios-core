//
// Created by Rene Dohan on 12/17/19.
//

import UIKit
import RenetikObjc

public class CSSearchBarController: CSMainController, UISearchBarDelegate {

    public let bar = UISearchBar.construct().resizeToFit()
    public var text: String { bar.text ?? "" }

    private var parentController: UIViewController!
    private var searchBarShouldBeginEditing = false
    private var onTextChanged: ((String) -> Void)!

    @discardableResult
    public func construct(by parent: CSMainController,
                          placeHolder: String = CSStrings.searchPlaceholder,
                          onTextChanged: @escaping (String) -> Void) -> Self {
        super.constructAsViewLess(in: parent)
        parentController = parent
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
        UIView.animate(0.3) { searchBar.showsCancelButton = true }
    }

    public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        UIView.animate(0.3) { searchBar.showsCancelButton = false }
    }
}
