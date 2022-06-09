import UIKit
public extension UIScrollView {

    @discardableResult
    func contentSize(width: CGFloat) -> Self {
        contentSize = CGSize(width: width, height: contentSize.height)
        return self
    }

    @discardableResult
    func contentSize(height: CGFloat) -> Self {
        contentSize = CGSize(width: contentSize.width, height: height)
        return self
    }

    @discardableResult
    func content(inset: UIEdgeInsets) -> Self { contentInset = inset; return self }

    func scrollable(_ isScrollEnabled: Bool) -> Self {
        self.isScrollEnabled = isScrollEnabled
        return self
    }

    var isAtTop: Bool { contentOffset.y <= verticalOffsetForTop }

    var isAtBottom: Bool {
//        let bottomEdge = contentOffset.y + height
//        return bottomEdge >= contentSize.height
        contentOffset.y >= verticalOffsetForBottom
    }

    var verticalOffsetForTop: CGFloat {
        let topInset = contentInset.top
        return -topInset
    }

    var verticalOffsetForBottom: CGFloat {
        let scrollViewHeight = bounds.height
        let scrollContentSizeHeight = contentSize.height
        let bottomInset = contentInset.bottom
        let scrollViewBottomOffset = scrollContentSizeHeight + bottomInset - scrollViewHeight
        return scrollViewBottomOffset.rounded()
    }

    func scrollToTop() {
        setContentOffset(CGPoint(x: contentOffset.x, y: -contentInset.top), animated: true)
    }

    func scrollToBottom() {
        setContentOffset(CGPoint(x: contentOffset.x,
            y: contentSize.height - bounds.size.height - contentInset.bottom), animated: true)
    }

    func scrollTo(page index: Int, of count: Int, animated: Bool = true) {
        let pageWidth = contentSize.width / CGFloat(count)
        let x = CGFloat(index) * pageWidth
        setContentOffset(CGPoint(x: x, y: 0), animated: animated)
    }

    func currentPageIndex(from: Int) -> Int {
        lround(Double(contentOffset.x / (contentSize.width / CGFloat(from))))
    }

    @discardableResult
    func contentOffset(top: CGFloat, animated: Bool = true) -> Self {
        invoke(animated: animated) {
            self.contentOffset = CGPoint(left: self.contentOffset.left, top: top)
        }
        return self
    }

    @discardableResult
    func contentOffset(left: CGFloat, animated: Bool = true) -> Self {
        invoke(animated: animated) {
            self.contentOffset = CGPoint(left: left, top: self.contentOffset.top)
        }
        return self
    }
}
