//
//  CameraViewController.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 8/16/23.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

#if os(iOS)

// MARK: - Imports

import SwiftUI

struct CameraViewController: UIViewControllerRepresentable {

    // MARK: - Properties - Objects

	@StateObject var photoManager: PhonePhotoManager

	@Bindable var phone: Phone

	// MARK: - Coordinator

	func makeCoordinator() -> CameraCoordinator {
		return CameraCoordinator(self, photoData: nil)
	}

	// MARK: - UIViewControllerRepresentable

	func makeUIViewController(context: Context) -> UIImagePickerController {
        // 1. Create a UIImagePickerController.
		let camera = UIImagePickerController()
        // 2. Set the delegate.
		camera.delegate = context.coordinator
        // 3. Set the source type to camera, which is now the only supported type.
		camera.sourceType = .camera
        // 4. Set the other properties.
		camera.cameraCaptureMode = .photo
		camera.allowsEditing = true
		camera.cameraFlashMode = .off
		camera.showsCameraControls = true
        // 5. Return the UIImagePickerController.
		return camera
	}

	func updateUIViewController(_ imagePickerController: UIImagePickerController, context: Context) {
	}

}
#endif
