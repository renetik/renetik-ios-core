//
// Created by Rene Dohan on 1/4/20.
//

import Foundation

public typealias CSStrings = String

public extension String {
    public static let cs_dialog_ok = localized("cs_dialog_ok")
    public static let cs_dialog_yes = localized("renetik_dialog_yes")
    public static let cs_dialog_no = localized("renetik_dialog_no")
    public static let cs_dialog_cancel = localized("renetik_dialog_cancel")

    public static let requestRetry = localized("renetik_request_retry")
    public static let requestCancel = localized("renetik_request_cancel")
    public static let requestFailed = localized("renetik_request_failed_message")
    public static let requestLoading = localized("renetik_request_loading")

    public static let tableLoadNextFailed = localized("renetik_table_load_next_failed_message")

    public static let operationCancelled = localized("renetik_operation_canceled_message")
    public static let operationFailed = localized("renetik_operation_failed_message")

    public static let searchPlaceholder = localized("renetik_search_placeholder")
}
