//
//  CSTableCellForHeightController.swift
//  Motorkari
//
//  Created by Rene Dohan on 12/31/17.
//  Copyright © 2017 Renetik Software. All rights reserved.
//

import RenetikObjc

class CSTableCellForHeightController: CSMainController {

    var cells: [UIView]!
    var cell: UIView { cells.first! }

    @discardableResult
    func construct(_ parent: CSMainController,
                   cell: UIView) -> Self { construct(parent, [cell]) }

    @discardableResult
    func construct(_ parent: CSMainController, _ cells: [UIView]) -> Self {
        super.constructAsViewLess(in: parent)
        self.cells = cells
        return self
    }

    override func onCreateLayout() {
        super.onCreateLayout()
        for cell in cells { view.add(view: cell).from(top: -500) }
    }

    override func onViewDidLayout() {
        super.onViewDidLayout()
        for cell in cells { cell.width(parentMain!.view.width) }
    }

    override func onViewWillTransition(to size: CGSize,
                                       _ coordinator: UIViewControllerTransitionCoordinator) {
        super.onViewWillTransition(to: size, coordinator)
        for cell in cells { cell.width(size.width) }
    }
}
