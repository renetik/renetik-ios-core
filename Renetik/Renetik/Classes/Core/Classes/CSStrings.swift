//
// Created by Rene Dohan on 1/4/20.
//

import Foundation

public typealias CSStrings = String

public extension String {
    public static let cs_dialog_ok = localized("cs_dialog_ok")
    public static let cs_dialog_yes = localized("cs_dialog_yes")
    public static let cs_dialog_no = localized("cs_dialog_no")
    public static let cs_dialog_cancel = localized("cs_dialog_cancel")

    public static let requestRetry = localized("cs_request_retry")
    public static let requestCancel = localized("cs_request_cancel")
    public static let requestFailed = localized("cs_request_failed_message")
    public static let requestLoading = localized("cs_request_loading")

    public static let tableLoadNextFailed = localized("cs_table_load_next_failed_message")

    public static let operationCancelled = localized("cs_operation_canceled_message")
    public static let operationFailed = localized("cs_operation_failed_message")

    public static let searchPlaceholder = localized("cs_search_placeholder")
}
