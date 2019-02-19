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
        return [
            DTUseiOS6Attributes: true,
            DTDefaultFontName: font.fontName,
            DTDefaultFontFamily: font.familyName,
            DTDefaultFontSize: font.pointSize,
            DTDefaultTextColor: textColor,
        ]
    }

    public func attributedTextContentView(_ attributedTextContentView: DTAttributedTextContentView!,
                                          viewForLink url: URL!, identifier: String!, frame: CGRect) -> UIView! {
        return UIView.construct().frame(frame).onTap { view in
            let controller = UIActivityViewController(activityItems: [url],
                                                      applicationActivities: [TUSafariActivity(), ARChromeActivity()])
            controller.popoverPresentationController?.sourceView = view
            CSAppDelegate.instance()
            navigation.last!.present(controller, animated: true, completion: nil)
        }
    }

    public func attributedTextContentView(_ contentView: DTAttributedTextContentView!,
                                          viewFor attachment: DTTextAttachment!, frame: CGRect) -> UIView! {
        if attachment is DTImageTextAttachment {
            let imageView = UIImageView.construct().frame(frame).imageNSURL(attachment.contentURL)
            if attachment.hyperLinkURL.notNil &&
                attachment.hyperLinkURL != attachment.contentURL {
                imageView.onTap { _ in
                    if UIApplication.shared.canOpenURL(attachment.hyperLinkURL) {
                        UIApplication.shared.open(attachment.hyperLinkURL)
                    }
                }
            } else if frame.width > 50 {
                imageView.onTap { _ in
                    let photoBrowser = IDMPhotoBrowser(photoURLs: [attachment.contentURL])!
                    photoBrowser.navigationItem.title = navigation.last?.navigationItem.title
                    photoBrowser.disableVerticalSwipe = true
                    navigation.push(fromTop: photoBrowser)
                }
            }
            return imageView
        }
        return nil
    }
}
