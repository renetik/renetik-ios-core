//
//  CSTableCellForHeightController.swift
//  Motorkari
//
//  Created by Rene Dohan on 12/31/17.
//  Copyright © 2017 Renetik Software. All rights reserved.
//

import RenetikObjc

@objc class CSTableCellForHeightController: CSChildViewLessController {
    var cells: [UIView]!
    @objc var cell: UIView { return cells.first! }

    @discardableResult
    @objc func construct(_ parent: CSMainController,
                         cell: UIView) -> Self { return construct(parent, [cell]) }

    @discardableResult
    @objc func construct(_ parent: CSMainController, _ cells: [UIView]) -> Self {
        super.construct(parent)
        self.cells = cells
        return self
    }

    override func onCreateLayout() {
        super.onCreateLayout()
        for cell in cells { view.add(view: cell).top(-500) }
    }

    override func onViewDidLayout() {
        super.onViewDidLayout()
        for cell in cells { cell.width(parentMain.view.width) }
    }

    override func onViewWillTransition(to
        size: CGSize, _ coordinator: UIViewControllerTransitionCoordinator) {
        super.onViewWillTransition(to: size, coordinator)
        for cell in cells { cell.width(size.width) }
    }
}
