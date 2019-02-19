//
//  CSClient.swift
//  Motorkari
//
//  Created by Rene Dohan on 1/28/19.
//  Copyright © 2019 Renetik Software. All rights reserved.
//

import AFNetworking
import RenetikObjc

@objc open class CSAFClient: NSObject {
    @objc public let url: String
    @objc let manager: AFHTTPSessionManager
    @objc var defaultParams: Dictionary<String, String> = [:]
    @objc public var requestFailedMessage = "Request failed"

    @objc public init(url: String) {
        self.url = url
        manager = AFHTTPSessionManager()
        manager.responseSerializer = AFHTTPResponseSerializer()
    }

    @objc public func addDefaultParams(_ params: Dictionary<String, String>) {
        defaultParams.add(params)
    }

    @objc public func clearDefaultParams() {
        defaultParams.removeAll()
    }

    //    @objc func cancelAllOperations() {
    //        manager.invalidateSessionCancelingTasks(true)
    //        manager = nil
    //    }

    @objc public func acceptableContentTypes(_ contentTypes: Array<String>) {
        manager.responseSerializer.acceptableContentTypes = Set<String>(contentTypes)
    }

    @objc public func basicAuhentification(username: String, password: String) {
        manager.requestSerializer.setAuthorizationHeaderFieldWithUsername(username, password: password)
    }

    @objc open func get(_ service: String, data: CSServerData, _ params: Dictionary<String, String>) -> CSResponse<CSServerData> {
        let response = CSResponse("\(url)\(service)", data, createParams(params))
        let responseListener = CSAFResponseListener(self, response)
        manager.get(response.url, parameters: response.params, progress: responseListener.onProgress, success: responseListener.onSuccess, failure: responseListener.onFailure)
        return response
    }

    @objc open func get(_ service: String, data: CSServerData) -> CSResponse<CSServerData> {
        return get(service, data: data, [:])
    }

    @objc open func post(_ service: String, data: CSServerData,
                         _ params: Dictionary<String, String>, form: @escaping (AFMultipartFormData) -> Void) -> CSResponse<CSServerData> {
        let response = CSResponse("\(url)\(service)", data, createParams(params))
        let responseListener = CSAFResponseListener(self, response)
        manager.post(response.url, parameters: response.params, constructingBodyWith: form, progress: responseListener.onProgress, success: responseListener.onSuccess, failure: responseListener.onFailure)
        return response
    }

    @objc open func post(_ service: String, data: CSServerData,
                         form: @escaping (AFMultipartFormData) -> Void) -> CSResponse<CSServerData> {
        return post(service, data: data, [:], form: form)
    }

    @objc open func post(_ service: String, data: CSServerData,
                         _ params: Dictionary<String, String>) -> CSResponse<CSServerData> {
        let response = CSResponse("\(url)\(service)", data, createParams(params))
        let listener = CSAFResponseListener(self, response)
        manager.post(response.url, parameters: response.params, progress: listener.onProgress, success: listener.onSuccess, failure: listener.onFailure)
        return response
    }

    private func createParams(_ params: Dictionary<String, String>) -> Dictionary<String, String> {
        var newParams = ["version": "IOS \(Bundle.shortVersion()) \(Bundle.build())"]
        newParams.add(defaultParams)
        newParams.add(params)
        return newParams
    }
}

@objc class CSAFResponseListener: NSObject {
    let client: CSAFClient
    let response: CSResponse<CSServerData>

    @objc init(_ client: CSAFClient, _ response: CSResponse<CSServerData>) {
        self.client = client
        self.response = response
    }

    @objc func onProgress(_ progress: Progress) {
        response.setProgress(progress.fractionCompleted)
    }

    @objc func onSuccess(_ task: URLSessionDataTask, _ data: Any?) {
        handleResponse(task, data as? Data, error: nil)
    }

    @objc func onFailure(_ task: URLSessionDataTask?, _ error: Error) {
        handleResponse(task, NSError.cast(error).userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] as? Data, error: NSError.cast(error))
    }

    @objc func handleResponse(_ task: URLSessionDataTask?, _ data: Data?, error: NSError?) {
        let content = data.notNil ? String(data: data!, encoding: .utf8)! : ""
        let request = task?.currentRequest
        logInfo("from \(String(describing: request?.url))")
        if response.url != request?.url?.absoluteString { logInfo("for \(response.url)") }
        logInfo(content)
        response.data.loadContent(content)
        if error.notNil && response.data.isEmpty { onHandleResponseError(error!, content) } else if response.data.success { response.success(response.data) } else { onRequestFailed() }
    }

    func onHandleResponseError(_ error: NSError, _ content: String) {
        logInfo("Failed \(error.code) \(error.localizedDescription) \(content)")
        response.failed(withMessage: error.localizedDescription)
    }

    func onRequestFailed() {
        if response.data.message.notNil { response.failed(withMessage: response.data.message) } else { response.failed(withMessage: client.requestFailedMessage) }
    }
}
