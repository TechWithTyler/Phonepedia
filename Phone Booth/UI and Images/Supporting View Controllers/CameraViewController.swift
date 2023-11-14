//
//  CameraViewController.swift
//  Phone Booth
//
//  Created by Tyler Sheft on 8/16/23.
//  Copyright © 2023 SheftApps. All rights reserved.
//

#if os(iOS)
import SwiftUI

struct CameraViewController: UIViewControllerRepresentable {

	var view: PhoneDetailView

	@Bindable var phone: Phone

	// MARK: - Coordinator

	func makeCoordinator() -> CameraCoordinator {
		return CameraCoordinator(self, photoData: nil)
	}

	// MARK: - UIViewControllerRepresentable

	func makeUIViewController(context: Context) -> UIImagePickerController {
		let camera = UIImagePickerController()
		camera.delegate = context.coordinator
		camera.sourceType = .camera
		camera.cameraCaptureMode = .photo
		camera.allowsEditing = true
		camera.cameraFlashMode = .off
		camera.showsCameraControls = true
		return camera
	}

	func updateUIViewController(_ imagePickerController: UIImagePickerController, context: Context) {
	}

}
#endif
