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

    static let dummy_number = "123"
    static let dummy_word = "Lorem"
    static let dummy_two_word = "Lorem Ipsum"
    static let dummy_short = "Lorem ipsum dolor"
    static let dummy_medium = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
    static let dummy_long = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    static let dummy_complete = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam sit amet nunc pulvinar, pulvinar nulla nec, suscipit ante. Donec finibus, diam in feugiat venenatis, libero turpis convallis massa, id ullamcorper lacus dui ac metus. Suspendisse potenti. Cras vehicula augue orci, id vulputate sem consectetur a. Nam tincidunt arcu in tellus venenatis consectetur. Aenean placerat, sapien sit amet semper sodales, ex est vehicula nibh, vitae volutpat ipsum orci non eros. Praesent a ante dui. Ut eget efficitur odio, eget congue erat."
}
