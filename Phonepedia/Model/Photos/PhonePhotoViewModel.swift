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

    // MARK: - Export Dragged Photo

    func handleDraggedPhotoForExport(phone: Phone) -> NSItemProvider {
        // 1. Make sure the phone has photo data. If not, return an empty NSItemProvider.
        guard let data = phone.photoData else { return NSItemProvider() }
        // 2. Define the filename and file extension for the exported image. The filename is the phone's brand and model number (e.g. "Some Brand M123-2").
        let filename = "\(phone.brand) \(phone.model)"
        let fileExtension = "png"
        // 3. Create a temporary file URL for the image.
        let temporaryDirectory = FileManager.default.temporaryDirectory
        let temporaryURL = temporaryDirectory.appending(path: "\(filename).\(fileExtension)", directoryHint: .notDirectory)
        // 4. Try to write the phone photo data to that temporary URL and return an NSItemProvider for that URL. If writing the data fails, show an error and return an empty NSItemProvider.
        do {
            try data.write(to: temporaryURL)
            return NSItemProvider(item: temporaryURL as NSSecureCoding, typeIdentifier: UTType.fileURL.identifier)
        } catch {
            phonePhotoError = .exportFailed(reason: "Error saving image to temporary file: \(error.localizedDescription)")
            showingPhonePhotoErrorAlert = true
            return NSItemProvider()
        }
    }

}
