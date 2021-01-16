//
// Created by Rene Dohan on 12/28/19.
// Copyright (c) 2019 Bowbook. All rights reserved.
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
        configuration.httpMaximumConnectionsPerHost = 10
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 60
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

    public func get<DataType: CSServerMapData>(_ operation: CSOperation<DataType>?, service: String,
                                               data: DataType, params: [String: String] = [:]) -> CSProcess<DataType> {
        CSProcess(url: "\(url)/\(service)", data: data).also { process in
            logInfo("\(process.url) \(HTTPMethod.get) \(params)")
            let loadFromNetwork: Bool = {
                if operation?.isRefresh == true { return true }
                if operation?.expireMinutes ?? 0 > 0 { return false }
                if networkReachability.isReachable { return true }
                return false
            }()
            let request = manager.request(url: process.url!, method: .get, parameters: params,
                    encoding: URLEncoding.default, refreshCache: loadFromNetwork)
            operation?.expireMinutes.notNil { minutes in request.cache(manager, maxAge: Double(minutes * 60)) }
            request.responseString(encoding: nil,
                    completionHandler: { self.onResponseDone(process, $0.response!.statusCode, $0.value, $0.error) },
                    autoClearCache: (operation?.isCached).isFalse)
        }
    }

    public func post(service: String, params: [String: String] = [:]) -> CSProcess<CSServerMapData> {
        post(service: service, data: CSServerMapData(), params: params)
    }

    public func post<DataType: CSServerMapData>(
            service: String, data: DataType, params: [String: Any] = [:]) -> CSProcess<DataType> {
        CSProcess(url: "\(url)/\(service)", data: data).also { process in
            logInfo("\(process.url) \(HTTPMethod.post) \(params)")
            manager.request(process.url!, method: .post, parameters: params,
                    encoding: JSONEncoding.default).responseString(encoding: nil) {
                self.onResponseDone(process, $0.response?.statusCode, $0.value, $0.error)
            }
        }
    }

    public func post<DataType: CSHttpResponseDataProtocol>(
            service: String, data: DataType, form: @escaping (MultipartFormData) -> Void) -> CSProcess<DataType> {
        CSProcess(url: "\(url)/\(service)", data: data).also { process in
            logInfo("\(process.url) \(HTTPMethod.post) \(form)")
            let credentialData = "\(basicAuth!.username):\(basicAuth!.password)".data(using: .utf8)!
            let base64Credentials = credentialData.base64EncodedData()
            let headers = ["Authorization": "Basic \(base64Credentials)"]
            manager.upload(multipartFormData: form, to: process.url!, headers: HTTPHeaders(headers))
                    .responseString(encoding: nil) {
                        self.onResponseDone(process, $0.response!.statusCode, $0.value, $0.error)
                    }
        }
    }

    public func download(service: String, params: [String: Any] = [:]) -> CSProcess<CSDownloadResponseData> {
        CSProcess(url: "\(url)/\(service)", data: CSDownloadResponseData()).also { process in
            logInfo("\(process.url) \(HTTPMethod.post) \(params)")
            let fileUrl = getDownloadFileUrl(fileName: "download.pdf")
            let destination: DownloadRequest.Destination =
                    { _, _ in (fileUrl, [.removePreviousFile, .createIntermediateDirectories]) }
            manager.download(process.url!, parameters: params, to: destination).downloadProgress { progress in
                let progressNumber = progress.completedUnitCount / progress.totalUnitCount
                logInfo(progressNumber)
            }.response { self.onResponseDone(process, $0.response!.statusCode, $0.fileURL?.path, $0.error) }
        }
    }

    func getDownloadFileUrl(fileName: String) -> URL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let nameUrl = URL(string: fileName)
        let fileURL = documentsURL.appendingPathComponent((nameUrl?.lastPathComponent)!)
        logInfo(fileURL.absoluteString)
        return fileURL;
    }

    private func onResponseDone<DataType: CSHttpResponseDataProtocol>(
            _ process: CSProcess<DataType>, _ statusCode: Int?, _ content: String?, _ error: Error?) {
        error.notNil { process.failed($0, message: "statusCode:\(statusCode), error:\(error), content:\(content) ") }
                .elseDo {
                    logInfo("\(process.url!) \(content ?? "No content")")
                    process.data!.onHttpResponse(code: statusCode!, message: "", content: content)
                    function(if: process.data!.success) { process.success() }
                            .elseDo { process.failed(nil, message: process.data!.message ?? "No Message") }
                }
    }
}

public class CSDownloadResponseData: CSHttpResponseData {
    public var url: URL { URL(fileURLWithPath: content!) }
}