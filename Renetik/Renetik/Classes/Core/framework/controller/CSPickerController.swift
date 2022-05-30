//
// Created by Rene Dohan on 2/19/20.
//

import Foundation
import UIKit

public class CSPickerController: CSViewController, CSPickerVisibleProtocol, UIPickerViewDelegate, UIPickerViewDataSource {

    public var isPickerVisible: Bool = false

    public static var toolBarColor: UIColor?
    public static var toolBarItemTextColor: UIColor?
    public static var pickerBackgroundColor: UIColor? = .white
    public static var itemTextColor: (normal: UIColor, selected: UIColor)?
    public static var itemBackgroundColor: (normal: UIColor, selected: UIColor)?
    public static var itemFont: (normal: UIFont, selected: UIFont)?
    public static var selectedItemBorder: (width: CGFloat, color: UIColor, radius: CGFloat)?

    var items: [CustomStringConvertible]!
    var onDone: ArgFunc<Int>!
    var onCancel: Func?

    @discardableResult
    public func showPicker(from parent: UIViewController, title: String, items: [CustomStringConvertible],
                           selected selectedIndex: Int, from displayElement: CSDisplayElement,
                           onCancel: Func?, onDone: @escaping ArgFunc<Int>) -> CSPickerVisibleProtocol {
        super.construct(parent).asViewLess()
        self.items = items
        self.onDone = onDone
        self.onCancel = onCancel
        let window = delegate.window!
        UIApplication.resignFirstResponder() // Hide keyboard or whatever so it don't overlap our view
        window.add(view: disablerView).matchParent()
        layout(disablerView.add(view: pickerView).matchParentWidth()) {
            $0.heightToFit().from(bottom: 0)
        }
        layout(disablerView.add(view: toolBar).matchParentWidth()) {
            $0.heightToFit().from(self.pickerView, bottom: 0)
        }
        window.layoutIfNeeded()
        pickerView.selectRow(selectedIndex, inComponent: 0, animated: false)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1,
                initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            window.layoutIfNeeded()
            self.disablerView.alpha = 1
        })
        return self
    }

    lazy var pickerView: UIPickerView = {
        let picker = UIPickerView.construct()
        picker.delegate = self
        picker.dataSource = self
        CSPickerController.pickerBackgroundColor.notNil { picker.backgroundColor = $0 }
        return picker
    }()

    lazy var disablerView: UIView = {
        let view = UIView().onClick { [unowned self] in self.onCancelClicked() }
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.alpha = 0
        return view
    }()

    lazy var toolBar: UIToolbar = {
        let toolBar = UIToolbar()
        CSPickerController.toolBarColor?.also { toolBar.barTintColor = $0 }
        CSPickerController.toolBarColor?.also { toolBar.backgroundColor = $0 }
        CSPickerController.toolBarItemTextColor?.also { toolBar.tintColor = $0 }
        let cancelButton = UIBarButtonItem(item: .cancel) { _ in self.onCancelClicked() }
        let doneButton = UIBarButtonItem(item: .done) { _ in self.onDoneClicked() }
        toolBar.items = [.space(7), cancelButton, .flexSpaceItem, doneButton, .space(7)]
        return toolBar
    }()

    public func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        items.count
    }

    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let isSelected = row == pickerView.selectedRow(inComponent: component)
        let pickerLabel = UILabel.construct()
        CSPickerController.itemFont.notNil { normal, selected in
            pickerLabel.font = isSelected ? selected : normal
        }.elseDo { pickerLabel.font = UIFont.systemFont(ofSize: UIFont.systemFontSize) }
        CSPickerController.itemTextColor.notNil { normal, selected in
            pickerLabel.textColor = isSelected ? selected : normal
        }.elseDo { pickerLabel.textColor = .darkText }
        CSPickerController.itemBackgroundColor.notNil { normal, selected in
            pickerLabel.backgroundColor = isSelected ? selected : normal
        }.elseDo { pickerLabel.backgroundColor = .clear }
        pickerLabel.textAlignment = .center
        pickerLabel.text = items[row].description
        if isSelected {
            CSPickerController.selectedItemBorder.notNil { width, color, radius in
                pickerLabel.border(width: width, color: color, radius: radius)
            }
        }
        return UIView.wrap(view: pickerLabel).content(padding: (horizontal: 8, vertical: 0))
    }

    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.reloadAllComponents()
    }

    func onDoneClicked() {
        hidePicker()
        onDone?(pickerView.selectedRow(inComponent: 0))
        parent!.dismissChild(controller: self)
    }

    func onCancelClicked() {
        hidePicker()
        onCancel?()
        parent!.dismissChild(controller: self)
    }

    public func hidePicker(animated: Bool = true) {
        invoke(animated: animated, duration: 0.7, operation: {
            self.disablerView.window!.layoutIfNeeded()
            self.disablerView.alpha = 0
        }, completion: {
            self.disablerView.removeFromSuperview()
        })
    }
}