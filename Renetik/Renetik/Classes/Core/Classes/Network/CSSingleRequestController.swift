//
// Created by Rene Dohan on 9/14/19.
//

import UIKit
import RenetikObjc
import BlocksKit

public class CSSingleRequestController2<Data: AnyObject>: CSChildViewLessController {

    public var requestFailedTitle = "Request failed"
    public var requestFailedMessage = "Repeat ?"
    public var requestFailedNo = "No"
    public var requestFailedYes = "Yes"

    var reloadResponse: CSResponse<Data>?
    var data: Data?
    var request: (() -> CSResponse<Data>)!
    var progressBlockedView: UIView!

    public func construct(_ parent: UIViewController,
                          _ progressBlockedView: UIView,
                          _ request: @escaping () -> CSResponse<Data>)
                    -> Self {
        super.construct(parent)
        self.progressBlockedView = progressBlockedView
        self.request = request
        return self
    }

    public func reload() {
        reloadResponse.notNil { $0.cancel() }
        progressLocal(show: request(),
                canCancel: data.notNil)
                .onSuccess { self.data = $0 }
                .onFailed { _ in
                    if self.data.notNil {
                        self.show(title: TextMessage.requestFailMessage, message: "Zopakovat ?",
                                positiveTitle: "Ano", onPositive: self.reload, negativeTitle: "Ne")
                    } else {
                        self.show(message: TextMessage.requestFailMessage, onPositive: self.reload)
                    }
                }.onDone { _ in self.reloadResponse = nil }
    }

    private func progressLocal<Data>(show
                                     response: CSResponse<Data>, canCancel
                                     isCancel: Bool = true) -> CSResponse<Data> {
        let progress = progressBlockedView.showProgress().apply {
            $0.contentColor = .white
            $0.bezelView.backgroundColor =
                    StyleColor.cardDark.add(alpha: 0.8)
            if isCancel {
                $0.button.title(TextTitle.cancel)
                $0.button.bk_addEventHandler({ _ in
                    response.cancel()
                }, for: .touchUpInside)
                $0.button.titleLabel!.fontStyle(.headline)
            }
        }
        UIActivityIndicatorView.cast(progress.bezelView.subviews[5]).apply {
            $0.tintColor = .white
            $0.color = .white
        }
        return response.onDone { _ in progress.hide(animated: true) }
    }
}

