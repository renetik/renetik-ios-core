//
// Created by Rene Dohan on 12/14/19.
// Copyright (c) 2019 Renetik Software. All rights reserved.
//

import MaterialComponents
import MaterialComponents.MDCPageControl
import UIKit
import Renetik

//import RenetikBlocksKit

class CSMDCPageControlScrollPager: CSViewController, UIScrollViewDelegate {

    var pageControl: MDCPageControl!
    var scrollView: UIScrollView!
    var createScrollViewContent: (() -> UIView)!
    var contentView: UIView?
    var currentPage = 0

    func construct(_ parent: CSViewController, _ pageControl: MDCPageControl, _ scrollView: UIScrollView,
                   _ count: Int, _ createScrollViewContent: @escaping () -> UIView) {
        super.construct(parent).asViewLess()
        self.pageControl = pageControl
        pageControl.numberOfPages = count
        pageControl.alpha = count > 1 ? 1 : 0 //BUG! hide/visible not works for MDCPageControl BUG!
        self.scrollView = scrollView
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        pageControl.addEventHandler(controlEvents: .valueChanged) {
            self.showPage(at: self.pageControl.currentPage)
        }
//        pageControl.bk_addEventHandler({ _ in
//            self.showPage(at: self.pageControl.currentPage)
//        }, for: .valueChanged)
        self.createScrollViewContent = createScrollViewContent
    }

    override func onViewWillAppear() { createContentView() }

    override func onViewDidTransition(
        to size: CGSize, _ context: UIViewControllerTransitionCoordinatorContext?) {
        animate { self.createContentView(animated: false) }
    }

    func createContentView(animated: Bool = true) {
        contentView?.removeFromSuperview()
        contentView = scrollView.content(horizontal: createScrollViewContent())
        showPage(at: currentPage, animated: animated)
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        pageControl.scrollViewDidEndScrollingAnimation(scrollView)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.scrollViewDidEndDecelerating(scrollView)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.scrollViewDidScroll(scrollView)
    }

    func showPage(at index: Int, animated: Bool = true) {
        currentPage = index
        scrollView.scrollTo(page: index, of: pageControl.numberOfPages, animated: animated)
    }
}