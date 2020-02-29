//
// Created by Rene Dohan on 12/22/19.
//

import Foundation
import UIKit
import RenetikObjc

public protocol CSImagePickerListener {
    func imagePicker(controller: CSImagePickerController, didFinishPickingMedia data: [UIImagePickerController.InfoKey: Any])
}

public typealias CSImagePickerParent = UIViewController & CSImagePickerListener & CSHasSheet & CSHasDialog

public class CSImagePickerController: NSObject, UIPopoverControllerDelegate,
        UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    private let parent: CSImagePickerParent!
    private var popover: UIPopoverController?

    public init(parent: CSImagePickerParent!) {
        self.parent = parent
    }

    @discardableResult
    public func show(from: CSDisplayElement) -> CSHasDialogVisible {
        parent.show(actions: [
            CSDialogAction(title: "Choose Photo") { self.onGalleryClick(from: from) },
            CSDialogAction(title: "Take Picture") { self.onCaptureClick() }
        ], from: from)
    }

    private func onGalleryClick(from element: CSDisplayElement) {
        popover = nil
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = true
            picker.sourceType = .photoLibrary
            parent.present(picker.popover(from: element))
        } else {
            parent.show(message: "Gallery not available")
        }
    }

    private func onCaptureClick() {
        popover = nil
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = true
            picker.sourceType = .camera
            parent.present(picker)
        } else {
            parent.show(message: "Camera not available")
        }
    }

    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo data: [UIImagePickerController.InfoKey: Any]) {
        dismiss()
        parent.imagePicker(controller: self, didFinishPickingMedia: data)
    }

    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) { dismiss() }

    private func dismiss() { popover?.dismiss(animated: true) ?? parent.dismiss() }
}
