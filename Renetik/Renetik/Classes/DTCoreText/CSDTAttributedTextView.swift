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
    private var numberOfImages = 0

    public override func construct() -> Self {
        super.construct()
        textDelegate = self
        attributedTextContentView.matchParentWidth()
        return self
    }

    @discardableResult
    public func textColor(_ color: UIColor) -> Self { invoke { self.textColor = color } }

    @discardableResult
    public func encoding(_ encoding: String.Encoding) -> Self { invoke { self.encoding = encoding } }

    @discardableResult
    public func html(_ html: String) -> Self { invoke { self.html = html } }

    @discardableResult
    public func fontStyle(_ fontStyle: UIFont.TextStyle) -> Self {
        font = UIFont.preferredFont(forTextStyle: fontStyle)
        return self
    }

    public var html = "" {
        didSet {
            imageUrls.clear()
            numberOfImages = html.countHtmlImageTagsWithoutSize()
            attributedString = NSAttributedString(htmlData: html.data(using: encoding),
                    options: attributedOptions, documentAttributes: nil)
        }
    }

    public var attributedOptions: [AnyHashable: Any] {
        [
//            DTUseiOS6Attributes: true,
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
            if attachment.displaySize.width == 0 {
                attachment.displaySize = CGSize(width: width, height: width / 2)
                self.relayoutText()
            }
            let imageView = UIImageView.construct().position(frame.origin).size(attachment.displaySize)
            if attachment.hyperLinkURL.notNil &&
                       attachment.hyperLinkURL != attachment.contentURL {
                imageView.image(url: attachment.contentURL) { $0.roundImageCorners(3) }.onClick {
                    if UIApplication.shared.canOpenURL(attachment.hyperLinkURL) {
                        UIApplication.shared.open(attachment.hyperLinkURL)
                    }
                }
            } else if attachment.displaySize.width > 50 {
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
        height(calculateHeightToFitWidth())
        return self
    }

    public override func calculateHeightToFitWidth() -> CGFloat {
        (html.isSet ? attributedTextContentView.calculateHeightToFitWidth() : 0)
                + (CGFloat(numberOfImages) * width / 2)
    }
}

private extension String {
    public func countHtmlImageTagsWithoutSize() -> Int {
        var endTagsToAddSize: Array<Int> = []
        let string = NSMutableString(string: self)
        var startTagIndex = -1
        repeat {
            startTagIndex = string.index(of: "<img ", from: startTagIndex + 1)
            if startTagIndex != NSString.notFound {
                let endTagIndex = string.index(of: "/>", from: startTagIndex + 1)
                let tagSubString = string.substring(from: startTagIndex, to: endTagIndex)
                if !tagSubString.contains("width=") {
                    endTagsToAddSize.append(endTagIndex)
                }
            }
        } while startTagIndex != NSString.notFound
        return endTagsToAddSize.count
    }
}

