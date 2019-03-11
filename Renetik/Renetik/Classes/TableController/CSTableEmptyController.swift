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

@objc public class CSTableEmptyController: NSObject
    , DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    @objc public var emptyText: String?
    @objc public var emptyDescription: String?
    @objc public var table: CSTableController<AnyObject>!
    @objc public var reloadImage: UIImage = UIImage()

    @nonobjc public func construct<RowType: AnyObject>(_ table: CSTableController<RowType>,
                                                       _ emptyText: String? = nil) {
        construct(table as! CSTableController<AnyObject>, emptyText)
    }

    @objc public func construct(_ table: CSTableController<AnyObject>,
                                _ emptyText: String? = nil) -> Self {
        self.table = table
        self.emptyText = emptyText
        table.tableView.emptyDataSetDelegate = self
        table.tableView.emptyDataSetSource = self
        return self
    }

    func title(forEmptyDataSet scrollView: UIScrollView?) -> NSAttributedString? {
        return (text() as NSString).attributed([
            NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline),
            NSAttributedString.Key.foregroundColor: UIColor(contrastingBlackOrWhiteColorOn: table.tableView.backgroundColor, isFlat: true),
        ])
    }

    func description(forEmptyDataSet scrollView: UIScrollView?) -> NSAttributedString? {
        if emptyDescription.notNil {
            var paragraph = NSMutableParagraphStyle()
            paragraph.lineBreakMode = .byWordWrapping
            paragraph.alignment = .center
            return emptyDescription!.attributed([
                NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .subheadline),
                NSAttributedString.Key.foregroundColor: UIColor.flatWhiteColorDark(),
                NSAttributedString.Key.paragraphStyle: paragraph,
            ])
        }
        return nil
    }

    func imageAnimation(forEmptyDataSet scrollView: UIScrollView?) -> CAAnimation? {
        let animation = CABasicAnimation(keyPath: "transform")
        animation.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
        animation.toValue = NSValue(caTransform3D: CATransform3DMakeRotation(CGFloat(M_PI_2), 0.0, 0.0, 1.0))
        animation.duration = 0.25
        animation.isCumulative = true
        animation.repeatCount = 4
        return animation
    }

    public func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return reloadImage
    }

    public func imageTintColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return UIColor(contrastingBlackOrWhiteColorOn:
            table.tableView.backgroundColor, isFlat: true)
    }

    public func emptyDataSetShouldAnimateImageView(_ scrollView: UIScrollView!) -> Bool {
        return true
    }

    public func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return .clear
    }

    public func emptyDataSetDidTap(_ scrollView: UIScrollView!) {
        table.reload()
    }

    public func emptyDataSetDidTapButton(_ scrollView: UIScrollView!) {
        table.reload()
    }

    public func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return 0
    }

    func text() -> String {
        if table.isFailed {
            return table.failedMessage.notNil ? table.failedMessage :
                "Loading of list content was not successful, click to try again"
        }
        return emptyText.notNil ? emptyText! : "No items in list to display at this time"
    }
}
