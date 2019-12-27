//
// Created by René Doháň on 9/28/19.
// Copyright (c) 2019 Renetik Software. All rights reserved.
//

import UIKit
import Renetik
import RenetikObjc

public class CSSingleRequestController<Data: AnyObject>: CSMainController {

    public var loadTitle = "Loading data..."
    public var failedTitle = "Request failed"
    public var failedMessage = "Repeat ?"
    public var failedPositiveButton = "Yes"

    private var reloadResponse: CSResponse<Data>?
    private var data: Data?
    private var request: (() -> CSResponse<Data>)!
    private var progressBlockedView: CSViewProtocol!

    public func construct(_ parent: UIViewController,
                          _ progressBlockedView: CSViewProtocol,
                          _ request: @escaping () -> CSResponse<Data>) -> Self {
        super.constructAsViewLess(in: parent)
        self.progressBlockedView = progressBlockedView
        self.request = request
        return self
    }

    public func reload() {
        reloadResponse?.cancel()
        progressBlockedView.show(progress: request(), title: loadTitle, canCancel: data.notNil)
                .onSuccess(onSuccess).onFailed(onFailed).onDone(onDone)
    }

    public func onSuccess(data: Data) {
        self.data = data
    }

    public func onFailed(response: CSResponse<AnyObject>) {
        self.progressBlockedView.show(title: self.failedTitle, message: self.failedMessage,
                positiveTitle: self.failedPositiveButton, onPositive: self.reload,
                canCancel: self.data.notNil)
    }

    public func onDone(data: Data) {
        self.reloadResponse = nil
    }
}