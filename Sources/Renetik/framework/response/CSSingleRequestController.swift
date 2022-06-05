//
// Created by René Doháň on 9/28/19.
// Copyright (c) 2019 Renetik Software. All rights reserved.
//

import UIKit

public class CSSingleRequestController<Data: CSAnyProtocol>: CSViewController {

    public var stringRequestLoading: String = .requestLoading
    public var stringRequestFailed: String = .requestFailed
    public var stringRequestRetry: String = .requestRetry

    private var reloadResponse: CSResponse<Data>?
    private var data: Data?
    private var request: (() -> CSResponse<Data>)!
    private var progressBlockedView: (CSResponseController & CSHasDialogProtocol)!

    public func construct(_ parent: UIViewController,
                          _ progressBlockedView: CSResponseController & CSHasDialogProtocol,
                          _ request: @escaping () -> CSResponse<Data>) -> Self {
        super.construct(parent).asViewLess()
        self.progressBlockedView = progressBlockedView
        self.request = request
        return self
    }

    public func reload() {
        reloadResponse?.cancel()
        progressBlockedView.show(request(), title: stringRequestLoading, canCancel: data.notNil)
                .onSuccess(onSuccess).onFailed(onFailed).onDone(onDone)
    }

    public func onSuccess(data: Data) {
        self.data = data
    }

    public func onFailed(response: CSResponseProtocol) {
        progressBlockedView.show(message: stringRequestFailed,
                positive: CSDialogAction(title: stringRequestRetry, action: reload))
    }

    public func onDone(data: Data?) {
        self.reloadResponse = nil
    }
}
