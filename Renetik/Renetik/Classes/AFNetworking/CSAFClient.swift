//
//  CSClient.swift
//  Motorkari
//
//  Created by Rene Dohan on 1/28/19.
//  Copyright © 2019 Renetik Software. All rights reserved.
//

import AFNetworking
import RenetikObjc

open class CSAFClient: CSObject {
    public let url: String
    let manager: AFHTTPSessionManager
    var defaultParams: Dictionary<String, String> = [:]
    public var requestFailedMessage = "Request failed"

    public init(url: String) {
        self.url = url
        manager = AFHTTPSessionManager()
        manager.responseSerializer = AFHTTPResponseSerializer()
    }

    public func setVagueSecurityPolicy() {
        var policy = AFSecurityPolicy(pinningMode: .none)
        policy.allowInvalidCertificates = true
        policy.validatesDomainName = false
        manager.securityPolicy = policy
    }

    public func addDefault(params: Dictionary<String, String>) {
        defaultParams.add(params)
    }

    public func clearDefaultParams() {
        defaultParams.removeAll()
    }

    public func acceptable(contentTypes: Array<String>) {
        manager.responseSerializer.acceptableContentTypes = Set<String>(contentTypes)
    }

    public func basicAuhentification(username: String, password: String) {
        manager.requestSerializer
            .setAuthorizationHeaderFieldWithUsername(username, password: password)
    }

    open func get<Data: CSServerData>(
        _ service: String, data: Data,
        _ params: Dictionary<String, String>) -> CSResponse<Data> {
        let response = CSResponse("\(url)\(service)", data, createParams(params))
        let responseListener = CSAFResponseListener(self, response)
        manager.get(response.url, parameters: response.params, progress: responseListener.onProgress, success: responseListener.onSuccess, failure: responseListener.onFailure)
        return response
    }

    open func get<Data: CSServerData>(
        _ service: String, data: Data) -> CSResponse<Data> {
        return get(service, data: data, [:])
    }

    open func post<Data: CSServerData>(
        _ service: String, data: Data,
        _ params: Dictionary<String, String>, form: @escaping (AFMultipartFormData) -> Void) -> CSResponse<Data> {
        let response = CSResponse("\(url)\(service)", data, createParams(params))
        let responseListener = CSAFResponseListener(self, response)
        manager.post(response.url, parameters: response.params, constructingBodyWith: form, progress: responseListener.onProgress, success: responseListener.onSuccess, failure: responseListener.onFailure)
        return response
    }

    open func post<Data: CSServerData>(_
        service: String, data: Data,
        form: @escaping (AFMultipartFormData) -> Void) -> CSResponse<Data> {
        return post(service, data: data, [:], form: form)
    }

    open func post<Data: CSServerData>(_
        service: String, data: Data,
        _ params: Dictionary<String, String>) -> CSResponse<Data> {
        let response = CSResponse("\(url)\(service)", data, createParams(params))
        let listener = CSAFResponseListener(self, response)
        manager.post(response.url, parameters: response.params, progress: listener.onProgress, success: listener.onSuccess, failure: listener.onFailure)
        return response
    }

    private func createParams(_
        params: Dictionary<String, String>) -> Dictionary<String, String> {
        var newParams = ["version": "IOS \(Bundle.shortVersion()) \(Bundle.build())"]
        newParams.add(defaultParams)
        newParams.add(params)
        return newParams
    }
}

public extension AFMultipartFormData {
    public func appendUTF8(parts: [String: String]) {
        logInfo(parts.asJson?.substring(to: 100))
        for (key, value) in parts {
            appendPart(withForm: value.data(using: .utf8)!, name: key)
        }
    }

    func appendImage(parts: [UIImage]) {
        logInfo(parts)
        for index in 0 ..< parts.count {
            appendPart(withFileData:
                parts[index].jpegData(compressionQuality: 0.8)!,
                name: "images[\(index)]",
                fileName: "mobileUpload.jpg", mimeType: "image/jpeg")
        }
    }
}

class CSAFResponseListener<ServerData: CSServerData>: NSObject {
    let client: CSAFClient
    let response: CSResponse<ServerData>

    init(_ client: CSAFClient, _ response: CSResponse<ServerData>) {
        self.client = client
        self.response = response
    }

    func onProgress(_ progress: Progress) {
        response.setProgress(progress.fractionCompleted)
    }

    func onSuccess(_ task: URLSessionDataTask, _ data: Any?) {
        handleResponse(task, data as? Data, error: nil)
    }

    func onFailure(_ task: URLSessionDataTask?, _ error: Error) {
        handleResponse(task, NSError.cast(error).userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] as? Data, error: NSError.cast(error))
    }

    func handleResponse(_ task: URLSessionDataTask?, _ data: Data?, error: NSError?) {
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
        if let message = response.data.message { response.failed(withMessage: message) }
        else { response.failed(withMessage: client.requestFailedMessage) }
    }
}
