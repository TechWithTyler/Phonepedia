//
//  CameraCoordinator.swift
//  Phone Booth
//
//  Created by Tyler Sheft on 8/16/23.
//  Copyright © 2023-2024 SheftApps. All rights reserved.
//

import SwiftUI

#if os(iOS)
class CameraCoordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

	var parent: CameraViewController

	init(_ cameraController: CameraViewController, photoData: Data?) {
		self.parent = cameraController
	}

	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true) {
            self.parent.viewModel.takingPhoto = false
        }
	}

	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		guard let cameraResult: UIImage = info[.originalImage] as? UIImage else {
			fatalError("Camera error!")
		}
		if let cameraResultData = cameraResult.jpegData(compressionQuality: 1.0) {
            parent.viewModel.checkImageForLandlines(cameraResultData, phone: parent.phone)
		}
        picker.dismiss(animated: true) {
            self.parent.viewModel.takingPhoto = false
        }
	}
}
#endif

