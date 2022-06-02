//
// Created by Rene Dohan on 12/17/19.
//

import UIKit

public class CSSearchBarController: CSViewController, UISearchBarDelegate {

    public let bar = UISearchBar.construct().resizeToFit()
    public var text: String { bar.text ?? "" }

    private var searchBarShouldBeginEditing = false
    private var onTextChanged: ((String) -> Void)!

    @discardableResult
    public func construct(by parent: CSViewController,
                          placeHolder: String = .searchPlaceholder,
                          onTextChanged: @escaping (String) -> Void) -> Self {
        super.construct(parent).asViewLess()
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

//TODO: What exactly was this good for ?
//    public func searchBarShouldBeginEditing(_ bar: UISearchBar) -> Bool {
//        let boolToReturn = searchBarShouldBeginEditing
//        searchBarShouldBeginEditing = true
//        return boolToReturn
//    }

    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        animate { searchBar.showsCancelButton = true }
    }

    public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        animate { searchBar.showsCancelButton = false }
    }
}