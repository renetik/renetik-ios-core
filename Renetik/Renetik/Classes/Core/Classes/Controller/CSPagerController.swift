//
// Created by Rene Dohan on 1/27/21.
//

import UIKit
import Renetik

public protocol CSPagerPage {
}

public protocol HasPages {
    associatedtype Page: CSViewController, CSPagerPage
    var pages: [Page] { get }
}

public class CSPagerController<Pages: HasPages>: CSViewController {

    public var currentIndex: Int = -1
    public var current: Pages.Page { pages[currentIndex] }

    private var _pages: Pages!
    public var pages: [Pages.Page] { _pages.pages }

    @discardableResult
    public func construct(_ parent: UIViewController, pages: Pages) -> Self {
        construct(parent)
        _pages = pages
        return self
    }

    public override func onViewWillAppearFirstTime() {
        super.onViewWillAppearFirstTime()
        show(index: 0)
    }

    public func show(page: Pages.Page) { pages.index(of: page)?.also { index in show(index, page) } }

    public func show(index: Int) { pages.at(index)?.also { page in show(index, page) } }

    private func show(_ index: Int, _ page: Pages.Page, _ animated: Bool = true) {
        if index == currentIndex { return }
        pages.at(currentIndex)?.also { current in
            dismissChild(controller: current)
            if currentIndex < index {
                CATransition.create(for: view, type: .push, subtype: .fromRight)
            } else if currentIndex > index {
                CATransition.create(for: view, type: .push, subtype: .fromLeft)
            }
        }
        add(controller: page).view.matchParent()
        currentIndex = index
    }

    public override func onViewDismissing() {
        super.onViewDismissing()
        pages.forEach { $0.onViewDismissing() }
    }
}
