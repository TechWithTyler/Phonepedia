//
//  CameraCoordinator.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 8/16/23.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI

#if os(iOS)
class CameraCoordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: - Properties - Parent View Controller

	var parent: CameraViewController

    // MARK: - Initialization

	init(_ cameraController: CameraViewController, photoData: Data?) {
		self.parent = cameraController
	}

    // MARK: - UIImagePickerControllerDelegate

	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true) {
            self.parent.viewModel.takingPhoto = false
        }
	}

	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 1. Make sure we can get the camera result.
		guard let cameraResult: UIImage = info[.originalImage] as? UIImage else {
			fatalError("Camera error!")
		}
        // 2. If we can get the data from that result, run it through the image predictor/set it as a photo.
		if let cameraResultData = cameraResult.jpegData(compressionQuality: 1.0) {
            parent.viewModel.showingLoadingPhoto = true
            parent.viewModel.checkImageForLandlinesAndSave(photoData: cameraResultData, phone: parent.phone)
		}
        // 3. Dismiss the camera.
        picker.dismiss(animated: true) {
            self.parent.viewModel.takingPhoto = false
        }
	}
}
#endif

