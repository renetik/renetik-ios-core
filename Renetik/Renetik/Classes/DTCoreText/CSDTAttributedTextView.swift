//
//  CSDTAttributeLabel.swift
//  Motorkari
//
//  Created by Rene Dohan on 2/7/19.
//  Copyright © 2019 Renetik Software. All rights reserved.
//

import ARChromeActivity
import DTCoreText
import IDMPhotoBrowser
import RenetikObjc
import TUSafariActivity
import UIKit

public class CSDTAttributedTextView: DTAttributedTextView, DTAttributedTextContentViewDelegate {
    public var font = UIFont.preferredFont(forTextStyle: .body)
    public var textColor: UIColor = .darkText
    public var encoding: String.Encoding = .utf8
    public var defaultLinkColor: UIColor = .blue
    private var imageUrls = [URL]()

    public func encoding(_ encoding: String.Encoding) -> Self {
        self.encoding = encoding
        return self
    }

    public override func construct() -> Self {
        super.construct()
        textDelegate = self
        return self
    }

    public var html = "" {
        didSet {
            let correctedHtml = html.addSizeToHtmlImageTags(self.width)
            attributedString = NSAttributedString(htmlData: correctedHtml.data(using: encoding),
                    options: attributedOptions, documentAttributes: nil)
        }
    }

    public var attributedOptions: [AnyHashable: Any] {
        [
            DTUseiOS6Attributes: true,
            DTDefaultFontName: font.fontName,
            DTDefaultFontFamily: font.familyName,
            DTDefaultFontSize: font.pointSize,
            DTDefaultTextColor: textColor,
            DTDefaultLinkColor: defaultLinkColor,
        ]
    }

    public func attributedTextContentView(_ attributedTextContentView: DTAttributedTextContentView!,
                                          viewForLink url: URL!, identifier: String!, frame: CGRect) -> UIView! {
        UIView.construct().frame(frame).also { view in
            view.onClick {
                let controller = UIActivityViewController(activityItems: [url],
                        applicationActivities: [TUSafariActivity(), ARChromeActivity()])
                controller.popoverPresentationController?.sourceView = view
                navigation.last!.present(controller, animated: true, completion: nil)
            }
        }
    }

    public func attributedTextContentView(_ contentView: DTAttributedTextContentView!,
                                          viewFor attachment: DTTextAttachment!, frame: CGRect) -> UIView! {
        if attachment is DTImageTextAttachment {
            let imageView = UIImageView.construct().frame(frame)
            if attachment.hyperLinkURL.notNil &&
                       attachment.hyperLinkURL != attachment.contentURL {
                imageView.image(url: attachment.contentURL) { $0.roundImageCorners(3) }.onClick {
                    if UIApplication.shared.canOpenURL(attachment.hyperLinkURL) {
                        UIApplication.shared.open(attachment.hyperLinkURL)
                    }
                }
            } else if frame.width > 50 {
                imageUrls.add(attachment.contentURL)
                imageView.image(url: attachment.contentURL) { $0.roundImageCorners(3) }.onClick {
                    let photoBrowser = IDMPhotoBrowser(photoURLs: self.imageUrls)!
                    photoBrowser.navigationItem.title = navigation.last?.navigationItem.title
                    photoBrowser.disableVerticalSwipe = true
                    navigation.push(fromTop: photoBrowser)
                }
            } else {
                imageView.image(url: attachment.contentURL)
            }
            return imageView
        }
        return nil
    }

    @discardableResult
    public override func heightToFit() -> Self {
        attributedTextContentView.heightToFit()
        height(attributedTextContentView.height)
        return self
    }

    @discardableResult
    public func heightToFit(characters count: Int) -> Self {
        let previousString = attributedString
        attributedString = NSAttributedString(string:
        String.randomString(length: count))
        attributedTextContentView.heightToFit()
        height(attributedTextContentView.height)
        attributedString = previousString
        return self
    }

    public override func calculateHeightToFitWidth() -> CGFloat {
        attributedTextContentView.calculateHeightToFitWidth()
    }
}
