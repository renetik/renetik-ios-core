//
// Created by Rene Dohan on 12/28/19.
// Copyright (c) 2019 Renetik. All rights reserved.
//

import Foundation
import Renetik
import RenetikObjc
import Alamofire

let INVALID_RESPONSE = "Invalid response from client"
let APPLICATION_ERROR = "Application error or invalid data"

public class CSAlamofireClient: CSObject {

    private let url: String
    private var host: String { url.remove("https://").remove("http://") }
    private var disabledTrustSecurity: Bool
    private var defaultParams: Dictionary<String, String> = [:]
    public var requestFailMessage = "Request failed"
    public var requestCancelMessage = "Request cancelled"
    private lazy var networkReachability = { NetworkReachabilityManager(host: self.host)! }()
    private var basicAuth: (username: String, password: String)?

    public init(url: String, disabledTrustSecurity: Bool = false) {
        self.url = url
        self.disabledTrustSecurity = disabledTrustSecurity
        super.init()
    }

    private lazy var manager: Session = {
        let configuration = URLSessionConfiguration.default
//        configuration.httpMaximumConnectionsPerHost = 10
//        configuration.timeoutIntervalForRequest = 60
//        configuration.timeoutIntervalForResource = 60
        let sessionDelegate = SessionDelegate()
        return Session(configuration: configuration, delegate: sessionDelegate,
                serverTrustManager: serverTrustManager)
    }()

    private var serverTrustManager: ServerTrustManager? {
        disabledTrustSecurity ? ServerTrustManager(evaluators: [host: DisabledEvaluator()]) : nil
    }

    public func addDefault(params: Dictionary<String, String>) {
        defaultParams.add(params)
    }

    public func clearDefaultParams() {
        defaultParams.removeAll()
    }

    public func basicAuthentication(username: String, password: String) {
        basicAuth = (username: username, password: password)
    }


    public func get<DataType: CSHttpResponseDataProtocol>(service: String, data: DataType,
                                                          params: [String: String] = [:]) -> CSProcess<DataType> {
        get(nil, service: service, data: data, params: params)
    }

    public func get<DataType: CSHttpResponseDataProtocol>(_ operation: CSOperation<DataType>?, service: String,
                                                          data: DataType, params: [String: String] = [:]) -> CSProcess<DataType> {
        CSProcess(url: "\(url)/\(service)", data: data).also { process in
            logInfo("\(HTTPMethod.get) \(process.url! + createUrlParams(params))")
            manager.request(process.url!, method: .get, parameters: params).responseString {
                self.onResponseDone(process, $0.response?.statusCode, $0.value, $0.error)
            }
        }
    }

    public func post(service: String, params: [String: String] = [:]) -> CSProcess<CSServerMapData> {
        post(service: service, data: CSServerMapData(), params: params)
    }

    public func post<DataType: CSHttpResponseDataProtocol>(
            service: String, data: DataType, params: [String: Any] = [:]) -> CSProcess<DataType> {
        CSProcess(url: "\(url)/\(service)", data: data).also { process in
            logInfo("\(HTTPMethod.post) \(process.url!) \(params)")
            manager.request(process.url!, method: .post, parameters: params).responseString {
                self.onResponseDone(process, $0.response?.statusCode, $0.value, $0.error)
            }
        }
    }

    public func post<DataType: CSHttpResponseDataProtocol>(
            service: String, data: DataType, form: @escaping (MultipartFormData) -> Void) -> CSProcess<DataType> {
        CSProcess(url: "\(url)/\(service)", data: data).also { process in
            logInfo("\(HTTPMethod.post) \(process.url!) \(form)")
//            let credentialData = "\(basicAuth!.username):\(basicAuth!.password)".data(using: .utf8)!
//            let base64Credentials = credentialData.base64EncodedData()
//            let headers = ["Authorization": "Basic \(base64Credentials)"] //headers: HTTPHeaders(headers)
            manager.upload(multipartFormData: form, to: process.url!).responseString {
                self.onResponseDone(process, $0.response!.statusCode, $0.value, $0.error)
            }
        }
    }

    public func download(service: String, params: [String: Any] = [:], fileName: String = "download.pdf") -> CSProcess<CSDownloadResponseData> {
        CSProcess(url: "\(url)/\(service)", data: CSDownloadResponseData()).also { [unowned self] process in
            logInfo("\(HTTPMethod.post) \(process.url!) \(params)")
            let destination: DownloadRequest.Destination =
                    { _, _ in (downloadFileUrl(fileName), [.removePreviousFile, .createIntermediateDirectories]) }
            manager.download(process.url!, parameters: params, to: destination).downloadProgress { progress in
                let progressNumber = progress.completedUnitCount / progress.totalUnitCount
                logInfo(progressNumber)
            }.response { self.onResponseDone(process, $0.response!.statusCode, $0.fileURL?.path, $0.error) }
        }
    }

    public func downloadFileUrl(_ fileName: String) -> URL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let nameUrl = URL(string: fileName)
        let fileURL = documentsURL.appendingPathComponent((nameUrl?.lastPathComponent)!)
        logInfo(fileURL.absoluteString)
        return fileURL;
    }

    private func onResponseDone<DataType: CSHttpResponseDataProtocol>(
            _ process: CSProcess<DataType>, _ statusCode: Int?, _ content: String?, _ error: Error?) {
        if error.notNil || statusCode == nil {
            process.failed(error, message: "statusCode:\(statusCode), error:\(error), content:\(content) ")
        } else {
            logInfo("\(process.url!) \(content ?? "No content")")
            process.data!.onHttpResponse(code: statusCode!, message: "", content: content)
            function(if: process.data!.success) { process.success() }
                    .elseDo { process.failed(nil, message: process.data!.message ?? "No Message") }
        }
    }

    private func createUrlParams(_ params: [String: String]) -> String {
        var urlParams = "?"
        for param in params {
            urlParams += "\(param.key)=\(param.value)&"
        }
        urlParams.removeLast()
        return urlParams
    }
}

public class CSDownloadResponseData: CSHttpResponseData {
    public var url: URL { URL(fileURLWithPath: content!) }
}