//
// Created by Rene Dohan on 12/25/20.
//

import Foundation

public protocol CSVisibilityProtocol {
    var isVisible: Bool { get set }
    var eventVisibilityChange: CSEvent<Bool> { get }
}