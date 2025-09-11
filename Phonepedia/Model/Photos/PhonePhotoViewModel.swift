//
//  PhonePhotoViewModel.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 12/19/23.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import PhotosUI

class PhonePhotoViewModel: ObservableObject {

    // MARK: - Properties - Image Predictor

    var imagePredictor: LandlineOrNotPredictor {
        return LandlineOrNotPredictor(photoViewModel: self)
    }

    // MARK: - Properties - Booleans

    @Published var showingPhonePhotoErrorAlert: Bool = false

    @Published var showingPhonePhotoExportSuccessfulAlert: Bool = false

    @Published var showingUnsurePhotoDataAlert: Bool = false

#if os(iOS)
    @Published var takingPhoto: Bool = false
#endif

    @Published var showingPhotoPicker: Bool = false

    @Published var showingResetAlert: Bool = false

    @Published var showingLoadingPhoto: Bool = false

    // MARK: - Properties - Data

    @Published var unsurePhotoDataToUse: Data? = nil

    // MARK: - Properties - Photos Picker Items

    @Published var selectedPhoto: PhotosPickerItem? = nil

    // MARK: - Properties - Errors

    @Published var phonePhotoError: PhonePhotoError? = nil

    // MARK: - Phone Photo Update - Photos Picker Selection

    func updatePhonePhotoToPickerSelection(for phone: Phone, oldValue: PhotosPickerItem?, newValue: PhotosPickerItem?) {
        guard let newValue = newValue else { return }
        let progress = newValue.loadTransferable(type: Data.self) { [self] result in
            // 1. Nil-out the photo picker selection after it's loaded into the app.
            DispatchQueue.main.async { [self] in
                selectedPhoto = nil
                switch result {
                case .success(let data):
                    // 2. If successful, check the photo for landline/VoIP phones. Ask the user for confirmation if no landline/VoIP phones could be detected.
                    checkImageForLandlines(photoData: data!, phone: phone)
                case .failure(let error as NSError):
                    // 3. If photo loading fails, log an error.
#if(DEBUG)
                    print("Error: \(error)")
#endif
                    phonePhotoError = .loadFailed(error: error)
                    showingPhonePhotoErrorAlert = true
                    showingLoadingPhoto = false
                }
            }
        }
        progress.resume()
        showingLoadingPhoto = true
    }

    // MARK: - Phone Photo Update - Drag and Drop

    func handleDroppedPhoto(phone: Phone, with provider: NSItemProvider) {
        let progress = provider.loadDataRepresentation(forTypeIdentifier: UTType.image.identifier) { [self] data, error in
            if let data = data {
                checkImageForLandlines(photoData: data, phone: phone)
            }
            if let error = error {
                phonePhotoError = .loadFailed(error: error)
                showingPhonePhotoErrorAlert = true
                showingLoadingPhoto = false
            }
        }
        progress.resume()
        showingLoadingPhoto = true
    }

    // MARK: - Phone Photo Update - Image Classification

    func checkImageForLandlines(photoData: Data, phone: Phone) {
        do {
            // 1. Pass the photo data through the LandlineOrNot image classification model to check it for landline/VoIP phones.
            try imagePredictor.makePredictions(for: photoData, phone: phone, completionHandler: imagePredictionHandler)
        } catch {
            // 2. If prediction fails, log an error.
            showingLoadingPhoto = false
            phonePhotoError = .predictionFailed(reason: "Vision was unable to make a prediction…\n\n\(error.localizedDescription)")
        }
    }

    private func imagePredictionHandler(_ predictions: [LandlineOrNotPredictor.Prediction]?, photoData: Data, phone: Phone) {
        // 1. Make sure we can get the first prediction. If we can't, log an error.
        showingLoadingPhoto = false
        guard let predictions = predictions, let firstPrediction = predictions.first else {
            phonePhotoError = .predictionFailed(reason: "No predictions available.")
            showingPhonePhotoErrorAlert = true
            return
        }
        // 2. If the photo contains landline/VoIP phones, set the photo without asking. If not, ask the user whether they want to use this photo anyways.
        if firstPrediction.isLandline {
            phone.photoData = photoData
        } else {
            unsurePhotoDataToUse = photoData
            showingUnsurePhotoDataAlert = true
        }
    }

    func savePhonePhotoToLibrary(phone: Phone) {
        // 2. Export the phone photo to an NSItemProvider.
        let itemProvider = exportPhonePhoto(phone: phone)
        // 3. Ensure that provider can load PNG data.
        if itemProvider.hasItemConformingToTypeIdentifier(UTType.png.identifier) {
            itemProvider.loadDataRepresentation(forTypeIdentifier: UTType.png.identifier) { [self] data, error in
                if let error = error {
                    phonePhotoError = .exportFailed(reason: error.localizedDescription)
                    showingPhonePhotoErrorAlert = true
                }
                guard let photoData = data else {
                    phonePhotoError = .exportFailed(reason: "Couldn't load photo data.")
                    showingPhonePhotoErrorAlert = true
                    return
                }
                // 4. Try to create an image from the photo data. If it fails, show an error.
                PHPhotoLibrary.shared().performChanges { [self] in
#if os(macOS)
                    let image = NSImage(data: photoData)
#else
                    let image = UIImage(data: photoData)
#endif
                    guard let image = image else {
                        phonePhotoError = .exportFailed(reason: "Couldn't create image from photo data.")
                        return
                    }
                    // 5. Try to save the image to the Photos library. If it fails, show an error.
                    PHAssetChangeRequest.creationRequestForAsset(from: image)
                } completionHandler: { [self] success, error in
                    if let error = error {
                        phonePhotoError = .exportFailed(reason: error.localizedDescription)
                        showingPhonePhotoErrorAlert = true
                    }
                    if success {
                        showingPhonePhotoExportSuccessfulAlert = true
                    }
                }
            }
        } else {
            // 6. If the item provider doesn't contain a file URL, show an error.
            phonePhotoError = .exportFailed(reason: "Item provider doesn't contain a file URL.")
            showingPhonePhotoErrorAlert = true
        }
    }


    // MARK: - Export Photo

    func exportPhonePhoto(phone: Phone) -> NSItemProvider {
        // 1. Define the filename and file extension for the exported image. The filename is the phone's brand and model number (e.g. "Some Brand M123-2").
        let filename = "\(phone.brand) \(phone.model)"
        // 3. Create an NSItemProvider that provides PNG data.
        let provider = NSItemProvider()
        provider.registerDataRepresentation(forTypeIdentifier: UTType.png.identifier, visibility: .all) { completion in
            completion(phone.photoData, nil)
            return nil
        }
        // 4. Set the filename for the exported photo.
        provider.suggestedName = "\(filename)"
        // 5. Return the provider.
        return provider
    }

}
