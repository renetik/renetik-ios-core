//
//  File.swift
//  Renetik
//
//  Created by Rene Dohan on 3/10/19.
//

import ChameleonFramework
import DZNEmptyDataSet
import RenetikObjc
import UIKit

@objc public class CSTableEmptyController: NSObject, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    @objc public var emptyText: String?
    @objc public var emptyDescription: String?
    @objc public var table: CSTableController<AnyObject>!
    @objc public var reloadImage = UIImage()
    @objc public var reloadImageTintColor: UIColor?
    @objc public var backgroundColor: UIColor? = .clear
    @objc public var titleFont = UIFont.preferredFont(forTextStyle: .title3).bold()
    @objc public var descriptionFont = UIFont.preferredFont(forTextStyle: .footnote)
    var text: String {
        if table.isFailed {
            return table.failedMessage.notNil ? table.failedMessage :
                    "Loading of list content was not successful, click to try again"
        }
        return emptyText.notNil ? emptyText! : "No items in list to display at this time"
    }

    @nonobjc public func construct<RowType: AnyObject>(_ table: CSTableController<RowType>,
                                                       _ title: String? = nil,
                                                       _ description: String? = nil) {
        construct(table as! CSTableController<AnyObject>, title, description)
    }

    @objc public func construct(_ table: CSTableController<AnyObject>,
                                _ title: String? = nil,
                                _ description: String? = nil) -> Self {
        self.table = table
        self.emptyText = title
        self.emptyDescription = description
        table.tableView.emptyDataSetDelegate = self
        table.tableView.emptyDataSetSource = self
        return self
    }

    public func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return text.attributed([
            NSAttributedString.Key.font: titleFont,
            NSAttributedString.Key.foregroundColor:
            UIColor(contrastingBlackOrWhiteColorOn: table.tableView.backgroundColor, isFlat: true),
        ])
    }

    public func description(forEmptyDataSet
                            scrollView: UIScrollView!) -> NSAttributedString! {
        if emptyDescription.isNil { return nil }
        var paragraph = NSMutableParagraphStyle()
        paragraph.lineBreakMode = .byWordWrapping
        paragraph.alignment = .center
        return emptyDescription!.attributed([
            NSAttributedString.Key.font: descriptionFont,
            NSAttributedString.Key.foregroundColor: UIColor.flatWhiteColorDark(),
            NSAttributedString.Key.paragraphStyle: paragraph,
        ])
    }

    public func imageAnimation(forEmptyDataSet scrollView: UIScrollView!) -> CAAnimation! {
        let animation = CABasicAnimation(keyPath: "transform")
        animation.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
        animation.toValue = NSValue(caTransform3D:
        CATransform3DMakeRotation(CGFloat(M_PI_2), 0.0, 0.0, 1.0))
        animation.duration = 0.25
        animation.isCumulative = true
        animation.repeatCount = 4
        return animation
    }

    public func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return reloadImage
    }

    public func imageTintColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor? {
        return reloadImageTintColor
    }

    public func emptyDataSetShouldAllowImageViewAnimate(_ scrollView: UIScrollView!) -> Bool {
        return true
    }

    public func emptyDataSetShouldAnimateImageView(_ scrollView: UIScrollView!) -> Bool {
        return true
    }

    public func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return backgroundColor
    }

    public func emptyDataSetDidTap(_ scrollView: UIScrollView!) {
        table.reload().onDone { _ in self.table.tableView.reloadEmptyDataSet() }
    }

    public func emptyDataSetDidTapButton(_ scrollView: UIScrollView!) {
        table.reload().onDone { _ in self.table.tableView.reloadEmptyDataSet() }
    }

    public func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return 0
    }
}
