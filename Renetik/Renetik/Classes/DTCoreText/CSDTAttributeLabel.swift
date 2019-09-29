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
import Renetik
import TUSafariActivity
import UIKit

public class CSDTAttributedLabel: DTAttributedLabel,
        DTAttributedTextContentViewDelegate, DTLazyImageViewDelegate {
    public var font = UIFont.preferredFont(forTextStyle: .body)
    public var textColor: UIColor = .darkText
    public var encoding: String.Encoding = .utf8
    public var defaultLinkColor: UIColor = .blue
    public var linksActive = true

    //	private let css = DTCSSStylesheet(styleBlock: """
//    body {
//    margin: 0;
//    padding: 0;
//    color: #666;
//    line-height: 250px;
//    font-family: Arial, serif;
//    font-size: 140pt;
//    font-weight: 500;
//    }
//    """)!
//
//    private let testHtml = """
//    <html>
//    <body>
//    <div style="font-weight: 800;">
//        <i>Test4 jsi diosj dioj dioj sio disj diosj iod jiod ios ioshiohsioh soi hiosh fioshdioshiodhsiodhsoi hdiosj oidsio dhsio dio jdioj siodj iojd oisjdois </i>
//    </div>
//    </body>
//    </html>
//    """

    public override func construct() -> Self {
        super.construct()
        delegate = self
        backgroundColor = .clear
        return self
    }

    public var html = "" {
        didSet {
            let correctedHtml = html.addSizeToHtmlImageTags(self.width)
            attributedString = NSAttributedString(
                    htmlData: html.data(using: encoding),
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
            DTDefaultLinkColor: defaultLinkColor,
        ]
    }

    @discardableResult
    public func height(toLines: Int) -> Self {
        height(UILabel.construct().width(width).font(font).height(toLines: toLines).height)
        numberOfLines = toLines
        lineBreakMode = .byTruncatingTail
        return self
    }

    @discardableResult
    @objc public func html(_ html: String) -> Self {
        self.html = html
        return self
    }

    @discardableResult
    @objc public func withBoldFont(_ isBold: Bool) -> Self {
        if isBold { font = font.bold() } else { font = font.normal() }
        return self
    }

    @discardableResult
    public func encoding(_ encoding: String.Encoding) -> Self {
        self.encoding = encoding
        return self
    }

    @discardableResult
    @objc public func textColor(_ textColor: UIColor) -> Self {
        self.textColor = textColor
        return self
    }

    @discardableResult
    @objc public func fontStyle(_ fontStyle: UIFont.TextStyle) -> Self {
        font = UIFont.preferredFont(forTextStyle: fontStyle)
        return self
    }

    public func attributedTextContentView(_
                                          attributedTextContentView: DTAttributedTextContentView!,
                                          viewForLink url: URL!, identifier: String!, frame: CGRect) -> UIView! {
        if !linksActive { return nil }
        return UIView.construct().frame(frame).onClick { view in
            let controller = UIActivityViewController(
                    activityItems: [url], applicationActivities: [TUSafariActivity(), ARChromeActivity()])
            controller.popoverPresentationController?.sourceView = view
            navigation.last!.present(controller, animated: true, completion: nil)
        }
    }

    @discardableResult
    public func sizeHeightToFit(characters count: Int) -> Self {
        let previousString = attributedString
        let randomString = String.randomString(length: count)
        attributedString = NSAttributedString(string: randomString)
        sizeFitWidth()
        attributedString = previousString
        return self
    }

//    public func attributedTextContentView(_
//        contentView: DTAttributedTextContentView!,
//        viewFor attachment: DTTextAttachment!, frame: CGRect) -> UIView! {
//        if attachment is DTImageTextAttachment {
//            let imageView = UIImageView.construct().frame(frame).imageNSURL(attachment.contentURL)
//            if attachment.hyperLinkURL.notNil &&
//                attachment.hyperLinkURL != attachment.contentURL {
//                imageView.onClick { _ in
//                    if UIApplication.shared.canOpenURL(attachment.hyperLinkURL) {
//                        UIApplication.shared.open(attachment.hyperLinkURL)
//                    }
//                }
//            } else if frame.width > 50 {
//                imageView.onClick { _ in
//                    let photoBrowser = IDMPhotoBrowser(photoURLs: [attachment.contentURL])!
//                    photoBrowser.navigationItem.title = navigation.last?.navigationItem.title
//                    photoBrowser.disableVerticalSwipe = true
//                    navigation.push(fromTop: photoBrowser)
//                }
//            }
//            return imageView
//        }
//        return nil
//    }

    public func attributedTextContentView(_
                                          contentView: DTAttributedTextContentView!,
                                          viewFor attachment: DTTextAttachment!, frame: CGRect) -> UIView! {
        if attachment.contentURL.absoluteString.hasPrefix("/") {
            let url = URL(string: "https://rcherz.com" + attachment.contentURL.absoluteString)!
            attachment.contentURL = url
        }
        if attachment is DTImageTextAttachment {
            let imageView = DTLazyImageView(frame: frame)
            imageView.contentMode = .scaleAspectFit
            imageView.delegate = self as DTLazyImageViewDelegate
            imageView.url = attachment.contentURL
            return imageView
        }
        return nil
    }

    public func lazyImageView(_ lazyImageView: DTLazyImageView,
                              didChangeImageSize: CGSize) {
        for attachment in layoutFrame.textAttachments() {
            let textAttachment = (attachment as! DTTextAttachment)
            if textAttachment.contentURL.absoluteString ==
                       lazyImageView.url.absoluteString {
                textAttachment.displaySize =
                        CGSize(width: didChangeImageSize.width + 10,
                                height: didChangeImageSize.height)
                textAttachment.verticalAlignment = .center
            }
        }
        relayoutText()
    }
}
