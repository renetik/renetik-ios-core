//
//  CSActionSheet.swift
//  Renetik
//
//  Created by Rene Dohan on 2/13/19.
//

import RenetikObjc

@objc public class CSActionDialog: NSObject, UIActionSheetDelegate {
    var sheet: UIActionSheet!
    var titles: Array<String> = []
    var actions: Array < () -> Void> = []

    var visible = false
    var title: String?
    var cancelTitle: String?
    var destructiveTitle: String?
    var onDestructive: (() -> Void)?
    var singleAction: ((Int) -> Void)?

    public func title(_ title: String) -> Self {
        self.title = title
        return self
    }

    public func cancel(_ cancel: String) -> Self {
        cancelTitle = cancel
        return self
    }

    public func destructive(_ title: String, _ onDestructive: @escaping () -> Void) -> Self {
        destructiveTitle = title
        self.onDestructive = onDestructive
        return self
    }

    public func destructive(_ onDestructive: @escaping () -> Void) -> Self {
        self.onDestructive = onDestructive
        return self
    }

    public func add(action title: String, _ action: @escaping () -> Void) -> Self {
        titles.append(title)
        actions.append(action)
        return self
    }

    func add(actions titles: Array<String>, _ action: @escaping (Int) -> Void) -> Self {
        self.titles.append(contentsOf: titles)
        singleAction = action
        return self
    }

    private func create() {
        sheet = UIActionSheet(title: title, delegate: self,
                              cancelButtonTitle: cancelTitle.notNil ? cancelTitle : "Cancel", destructiveButtonTitle: destructiveTitle)
        for title: String in titles { sheet.addButton(withTitle: title) }
        visible = true
    }

    public func actionSheet(_ actionSheet: UIActionSheet, didDismissWithButtonIndex buttonIndex: Int) {
        if onDestructive.notNil && buttonIndex == actionSheet.destructiveButtonIndex {
            run(onDestructive)
        } else if buttonIndex != actionSheet.cancelButtonIndex {
            if let action = actions.at(buttonIndex - 1) { action() }
            else { singleAction?(buttonIndex) }
        }
        reset()
    }

    func reset() {
        sheet = nil
        titles.removeAll()
        actions.removeAll()
        visible = false
        title = nil
        cancelTitle = nil
        destructiveTitle = nil
        onDestructive = nil
        singleAction = nil
    }

    public func show(from barItem: UIBarButtonItem) {
        create()
        if UIDevice.iPad() { sheet.show(from: barItem, animated: true) }
        else { sheet.show(in: CSAppDelegate.instance().window!) }
    }

    public func show(from view: UIView) {
        create()
        if UIDevice.iPad() { sheet.show(from: view.frame, in: view.superview!, animated: true) }
        else { sheet.show(in: CSAppDelegate.instance().window!) }
    }

    public func hide() {
        sheet.dismiss(withClickedButtonIndex: titles.count, animated: true)
    }
}
