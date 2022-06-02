//
// Created by Rene Dohan on 2/19/20.
//

import UIKit

public protocol CSHasPickerProtocol {
    @discardableResult
    func show(picker title: String, items: [CustomStringConvertible], selected index: Int,
              from element: CSDisplayElement, onCancel: Func?,
              onDone: @escaping (Int) -> Void) -> CSPickerVisibleProtocol
}

public extension CSHasPickerProtocol {
    @discardableResult
    func show(picker title: String, items: [String], selected: Int = 0,
              from view: UIView, onCancel: Func? = nil,
              onDone: @escaping (Int) -> Void) -> CSPickerVisibleProtocol {
        show(picker: title, items: items, selected: selected,
                from: CSDisplayElement(view: view), onCancel: onCancel, onDone: onDone)
    }

    @discardableResult
    func show(picker title: String, items: [String], selected: Int = 0,
              from item: UIBarButtonItem, onCancel: Func? = nil,
              onDone: @escaping (Int) -> Void) -> CSPickerVisibleProtocol {
        show(picker: title, items: items, selected: selected,
                from: CSDisplayElement(item: item), onCancel: onCancel, onDone: onDone)
    }

    @discardableResult
    func show<T: CustomStringConvertible>(
            picker title: String, items: [T], selected: Int = 0,
            from view: UIView, onCancel: Func? = nil,
            onDone: @escaping ArgFunc<T>) -> CSPickerVisibleProtocol {
        show(picker: title, items: items, selected: selected,
                from: CSDisplayElement(view: view), onCancel: onCancel, onDone: { onDone(items[$0]) })
    }

    @discardableResult
    func show<T: CustomStringConvertible & Equatable>(picker title: String, items: [T], selected: T? = nil,
                                                      from view: UIView, onCancel: Func? = nil, onDone: @escaping (T) -> Void) -> CSPickerVisibleProtocol {
        let selectedIndex = selected != nil ? (items.index(of: selected!) ?? 0) : 0
        return show(picker: title, items: items, selected: selectedIndex, from: view, onCancel: onCancel, onDone: onDone)
    }

    @discardableResult
    func show<T: CustomStringConvertible>(picker title: String, items: [T], selected: Int = 0,
                                          from item: UIBarButtonItem, onCancel: Func? = nil,
                                          onDone: @escaping (T) -> Void) -> CSPickerVisibleProtocol {
        show(picker: title, items: items, selected: selected,
                from: CSDisplayElement(item: item), onCancel: onCancel, onDone: { onDone(items[$0]) })
    }
}

public protocol CSPickerVisibleProtocol {
    var isPickerVisible: Bool { get }
    func hidePicker(animated: Bool)
}

public extension CSPickerVisibleProtocol {
    func hidePicker() { hidePicker(animated: true) }
}
