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
    public let manager: AFHTTPSessionManager
    var defaultParams: Dictionary<String, String> = [:]
    public var requestFailedMessage = "Request failed"

    public init(url: String) {
        self.url = url
        let configuration = URLSessionConfiguration.default
        configuration.httpMaximumConnectionsPerHost = 10
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 60
        manager = AFHTTPSessionManager(baseURL: URL(string: url),
                                       sessionConfiguration: configuration)
        manager.responseSerializer = AFHTTPResponseSerializer()
    }

    public func setVagueCertificateSecurityPolicy() {
        var policy = AFSecurityPolicy(pinningMode: .none)
        policy.allowInvalidCertificates = true
        policy.validatesDomainName = false
        manager.securityPolicy = policy
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
        let request = CSResponse(url, service, data, createParams(params))
        request.type = .get
        let response = CSAFResponse(self, request)
        execute(request, response)
//        manager.get(service, parameters: response.params, progress: responseListener.onProgress, success: responseListener.onSuccess, failure: responseListener.onFailure)
        return request
    }

    open func get<Data: CSServerData>(
        _ service: String, data: Data) -> CSResponse<Data> {
        return get(service, data: data, [:])
    }

    open func post<Data: CSServerData>(
        _ service: String, data: Data,
        _ params: Dictionary<String, String>,
        form: @escaping (AFMultipartFormData) -> Void) -> CSResponse<Data> {
        let request = CSResponse(url, service, data, createParams(params))
        request.type = .post
        request.form = form
        let response = CSAFResponse(self, request)
//        execute(request, response)
        manager.post(service, parameters: request.params, constructingBodyWith: form,
                     progress: response.onProgress, success: response.onSuccess,
                     failure: response.onFailure)
        return request
    }

    open func post<Data: CSServerData>(_
        service: String, data: Data,
        form: @escaping (AFMultipartFormData) -> Void) -> CSResponse<Data> {
        return post(service, data: data, [:], form: form)
    }

    open func post<Data: CSServerData>(_
        service: String, data: Data,
        _ params: Dictionary<String, String>) -> CSResponse<Data> {
        let request = CSResponse(url, service, data, createParams(params))
        request.type = .post
        let response = CSAFResponse(self, request)
        execute(request, response)
//        manager.post(service, parameters: response.params,
//                     progress: listener.onProgress, success: listener.onSuccess,
//                     failure: listener.onFailure)
        return request
    }

    private func createParams(_
        params: Dictionary<String, String>) -> Dictionary<String, String> {
        var newParams = ["version": "IOS \(Bundle.shortVersion()) \(Bundle.build())"]
        newParams.add(defaultParams)
        newParams.add(params)
        return newParams
    }

    func execute<Data: CSServerData>(
        _ request: CSResponse<Data>, _ response: CSAFResponse<Data>) {
        if request.type == .get {
            manager.get(request.service, parameters: request.params, progress: response.onProgress, success: response.onSuccess, failure: response.onFailure)
        } else {
            if request.form.notNil {
                manager.post(request.service, parameters: request.params, constructingBodyWith: request.form!, progress: response.onProgress,
                             success: response.onSuccess, failure: response.onFailure)
            } else {
                manager.post(request.service, parameters: request.params,
                             progress: response.onProgress, success: response.onSuccess,
                             failure: response.onFailure)
            }
        }
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

class CSAFResponse<ServerData: CSServerData>: NSObject {
    let client: CSAFClient
    let request: CSResponse<ServerData>
    var retryCount = 0

    init(_ client: CSAFClient, _ response: CSResponse<ServerData>) {
        self.client = client
        request = response
    }

    func onProgress(_ progress: Progress) {
        request.setProgress(progress.fractionCompleted)
    }

    func onSuccess(_ task: URLSessionDataTask, _ data: Any?) {
        handleResponse(task, data as? Data, error: nil)
    }

    func onFailure(_ task: URLSessionDataTask?, _ error: Error) {
        handleResponse(task, NSError.cast(error).userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] as? Data, error: NSError.cast(error))
    }

    func handleResponse(_ task: URLSessionDataTask?, _ data: Data?, error: NSError?) {
        logUrl(task)
        let content = data.notNil ? String(data: data!, encoding: .utf8)! : ""
        logInfo(content)
        request.data.loadContent(content)
        if error.notNil && request.data.isEmpty {
            onHandleResponseError(task?.response, error!, content) }
        else if request.data.success { request.success(request.data) }
        else { onRequestFailed() }
    }

    func logUrl(_ task: URLSessionDataTask?) {
        let taskRequest = task?.currentRequest
        logInfo("from \(taskRequest?.url.asString)")
        let requestUrl = "\(request.url)\(request.service)"
        if requestUrl != taskRequest?.url?.absoluteString { logInfo("for \(requestUrl)") }
    }

    func onHandleResponseError(_ httpResponse: URLResponse?, _ error: NSError, _ content: String) {
        logWarn("Failed \(String(describing: httpResponse)) \(error.code) \(error.localizedDescription) \(content)")
        // Sometimes reciving code -999 canceled
        if error.code == -999 && retryCount < 3 {
            retryCount += 1
            logInfo("-999 Zruseno Retrying..." + httpResponse.asString)
            client.execute(request, self)
        } else {
            request.failed(withMessage: error.localizedDescription)
        }
    }

    func onRequestFailed() {
        if let message = request.data.message { request.failed(withMessage: message) }
        else { request.failed(withMessage: client.requestFailedMessage) }
    }
}
