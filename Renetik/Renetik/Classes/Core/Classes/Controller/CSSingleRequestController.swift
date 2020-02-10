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
    private var progressBlockedView: (CSResponseController & CSHasDialog)!

    public func construct(_ parent: UIViewController,
                          _ progressBlockedView: (CSResponseController & CSHasDialog),
                          _ request: @escaping () -> CSResponse<Data>) -> Self {
        super.constructAsViewLess(in: parent)
        self.progressBlockedView = progressBlockedView
        self.request = request
        return self
    }

    public func reload() {
        reloadResponse?.cancel()
        progressBlockedView.show(request(), canCancel: data.notNil)
                //        progressBlockedView.show(progress: request(), title: loadTitle, canCancel: data.notNil)
                .onSuccess(onSuccess).onFailed(onFailed).onDone(onDone)
    }

    public func onSuccess(data: Data) {
        self.data = data
    }

    public func onFailed(response: CSResponse<AnyObject>) {
        progressBlockedView.show(title: failedTitle, message: failedMessage,
                positive: CSDialogAction(title: failedPositiveButton, action: reload),
                negative: nil, cancel: nil)
//        progressBlockedView.show(title: failedTitle, message: failedMessage,
//                positiveTitle: failedPositiveButton, onPositive: reload,
//                canCancel: data.notNil)
    }

    public func onDone(data: Data) {
        self.reloadResponse = nil
    }
}