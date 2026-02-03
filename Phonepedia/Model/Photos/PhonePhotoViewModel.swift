//
//  PhonePhotoViewModel.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 12/19/23.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI
import PhotosUI

class PhonePhotoViewModel: ObservableObject {

    // MARK: - Properties - Image Predictor

    // The image predictor used to check images for landline/VoIP phones.
    var imagePredictor: LandlineOrNotPredictor {
        return LandlineOrNotPredictor(photoViewModel: self)
    }

    // MARK: - Properties - Booleans

    // Whether the phone photo error alert should be/is being displayed.
    @Published var showingPhonePhotoErrorAlert: Bool = false

    // Whether the phone photo export success alert should be/is being displayed.
    @Published var showingPhonePhotoExportSuccessfulAlert: Bool = false

    // Whether the "use this photo?" alert should be/is being displayed.
    @Published var showingUnsurePhotoDataAlert: Bool = false

    // Whether the camera should be/is being displayed.
#if os(iOS)
    @Published var takingPhoto: Bool = false
#endif

    // Whether a draggable item (e.g. an image file) is being hovered over the photo.
    @Published var hoveringItemOverPhoto: Bool = false

    // Whether the photo picker should be/is being displayed.
    @Published var showingPhotoPicker: Bool = false

    // Whether the reset alert should be/is being displayed.
    @Published var showingResetAlert: Bool = false

    // Whether the phone detail view should indicate that a new photo is being loaded.
    @Published var showingLoadingPhoto: Bool = false

    // MARK: - Properties - Data

    // The photo data that was detected as not a landline/VoIP phone.
    @Published var unsurePhotoDataToUse: Data? = nil

    // MARK: - Properties - Photos Picker Items

    // The photo selected in the photo picker.
    @Published var selectedPhoto: PhotosPickerItem? = nil

    // MARK: - Properties - Errors

    // The error shown if photo selection/prediction fails.
    @Published var phonePhotoError: PhonePhotoError? = nil

    // MARK: - Properties - Type Identifiers

    // The type identifier for PNG image files.
    let pngTypeIdentifier = UTType.png.identifier

    // MARK: - Phone Photo Update - Photos Picker Selection

    // This method handles selecting a photo in the photo picker.
    func handlePhotoPickerSelection(for phone: Phone, newValue: PhotosPickerItem?) {
        guard let newValue = newValue else { return }
        let progress = newValue.loadTransferable(type: Data.self) { [self] result in
            // 1. Nil-out the photo picker selection after the photo is loaded into the app.
            DispatchQueue.main.async { [self] in
                selectedPhoto = nil
                switch result {
                case .success(let data):
                    // 2. If we get the data from the photo picker result, run the photo through the image predictor to check it for landline/VoIP phones. Ask the user for confirmation if no landline/VoIP phones could be detected. If we can't get data, show an error.
                    if let data = data {
                        checkPhotoForLandlinesAndSave(photoData: data, phone: phone)
                    } else {
                        phonePhotoError = .noPhotoDataPhotoPicker
                        showingPhonePhotoErrorAlert = true
                        showingLoadingPhoto = false
                    }
                case .failure(let error):
                    // 3. If photo loading fails, show an error.
#if(DEBUG)
                    print("Error: \(error)")
#endif
                    phonePhotoError = .loadFailed(error: error)
                    showingPhonePhotoErrorAlert = true
                    showingLoadingPhoto = false
                }
            }
        }
        // 4. Start loading.
        progress.resume()
        showingLoadingPhoto = true
    }

    // MARK: - Phone Photo Update - Drag and Drop

    // This method handles dropping of a photo on the phone photo.
    func handleDroppedPhoto(phone: Phone, with providers: [NSItemProvider]) -> Bool {
        // 1. Make sure only one item is being dropped. If 2 or more items are being dropped, show an error.
        let itemCount = providers.count
        guard itemCount == 1 else {
            phonePhotoError = .tooManyPhotos(count: itemCount)
            showingPhonePhotoErrorAlert = true
            return false
        }
        // 2. Make sure we can get the first item provider. If we can't, return false.
        guard let provider = providers.first else {
            return false
        }
        // 3. Try to have the provider load image data. If successful, check the photo for landline/VoIP phones. Ask the user for confirmation if no landline/VoIP phones could be detected. If unsuccessful, show an error.
        let progress = provider.loadDataRepresentation(forTypeIdentifier: UTType.image.identifier) { [self] data, error in
            if let data = data {
                checkPhotoForLandlinesAndSave(photoData: data, phone: phone)
            } else if let error = error {
                phonePhotoError = .loadFailed(error: error)
                showingPhonePhotoErrorAlert = true
                showingLoadingPhoto = false
            } else {
                phonePhotoError = .noPhotoDataDrop
                showingPhonePhotoErrorAlert = true
                showingLoadingPhoto = false
            }
        }
        // 4. Start loading.
        progress.resume()
        showingLoadingPhoto = true
        // 5. Return whether the drop was successful. This is determined by whether the phone photo error alert is being displayed.
        return !showingPhonePhotoErrorAlert
    }

    // MARK: - Phone Photo Update - Image Classification/Saving

    // This method runs photoData through the image predictor and checks it for landline/VoIP phones.
    func checkPhotoForLandlinesAndSave(photoData: Data, phone: Phone) {
        // Run the photo data through the LandlineOrNot image classification model to check it for landline/VoIP phones.
        imagePredictor.makePredictions(for: photoData, phone: phone, completionHandler: imagePredictionHandler)
    }

    // This method is called as the completion handler after image prediction, and gives back the photo data and the phone whose photo data is to be set to that data.
    private func imagePredictionHandler(_ predictions: [LandlineOrNotPredictor.Prediction]?, photoData: Data, phone: Phone) {
        // 1. Make sure we can get the first prediction. If we can't, show an error.
        DispatchQueue.main.async { [self] in
            showingLoadingPhoto = false
        }
        guard let predictions = predictions, let firstPrediction = predictions.first else {
            phonePhotoError = .predictionFailed(reason: "No predictions available.")
            DispatchQueue.main.async { [self] in
                showingPhonePhotoErrorAlert = true
            }
            return
        }
        // 2. If the photo contains landline/VoIP phones, set the photo without asking. If not, ask the user whether they want to use this photo anyways.
        if firstPrediction.isLandline {
            phone.photoData = photoData
        } else {
            DispatchQueue.main.async { [self] in
                unsurePhotoDataToUse = photoData
                showingUnsurePhotoDataAlert = true
            }
        }
    }

    // MARK: - Export Photo - Item Provider

    // This method creates an NSItemProvider when exporting a phone's photo.
    func exportPhonePhoto(phone: Phone) -> NSItemProvider {
        // 1. Define the filename for the exported photo. The filename is the phone's brand and model number (e.g. "Some Brand M123-2").
        let filename = "\(phone.brand) \(phone.model)"
        // 2. Create an NSItemProvider that provides PNG data. This sets the file extension to ".png".
        let itemProvider = NSItemProvider()
        if let data = phone.photoData {
            itemProvider.registerDataRepresentation(forTypeIdentifier: pngTypeIdentifier, visibility: .all) { completion in
                completion(data, nil)
                return nil
            }
            // 3. Set the filename for the exported photo.
            itemProvider.suggestedName = filename
        }
        // 4. Return the provider.
        return itemProvider
    }

    // MARK: - Export Photo - Save to Photos Library

    // This method saves phone's photo to the user's Photos library.
    func savePhonePhotoToLibrary(phone: Phone) {
        // 1. Export the phone photo to an NSItemProvider.
        let itemProvider = exportPhonePhoto(phone: phone)
        // 2. Ensure that item provider contains PNG data. If so, try to load it. If successful, the data is passed to the completion handler and used there.
        let containsPNGData = itemProvider.hasItemConformingToTypeIdentifier(pngTypeIdentifier)
        if containsPNGData {
            itemProvider.loadDataRepresentation(forTypeIdentifier: pngTypeIdentifier) { [self] data, error in
                if let error = error {
                    phonePhotoError = .exportFailed(reason: error.localizedDescription)
                    showingPhonePhotoErrorAlert = true
                }
                guard let photoData = data else {
                    phonePhotoError = .exportFailed(reason: "Couldn't load photo data.")
                    showingPhonePhotoErrorAlert = true
                    return
                }
                // 3. Try to create an image from that data. If it fails, show an error.
#if os(macOS)
                let image = NSImage(data: photoData)
#else
                let image = UIImage(data: photoData)
#endif
                guard let image = image else {
                    phonePhotoError = .exportFailed(reason: "Couldn't create image from photo data.")
                    return
                }
                // 4. Try to save the image to the Photos library. If it fails, show an error.
                PHPhotoLibrary.shared().performChanges {
                    PHAssetChangeRequest.creationRequestForAsset(from: image)
                } completionHandler: { [self] success, error in
                    if let error = error {
                        phonePhotoError = .exportFailed(reason: error.localizedDescription)
                        showingPhonePhotoErrorAlert = true
                    }
                    if !success && error == nil {
                        phonePhotoError = .exportFailed(reason: "Unknown error")
                        showingPhonePhotoErrorAlert = true
                    } else {
                        showingPhonePhotoExportSuccessfulAlert = true
                    }
                }
            }
        }
    }

    // MARK: - Dismiss Error Alert

    // This method dismisses the error alert.
    func dismissErrorAlert() {
        showingPhonePhotoErrorAlert = false
        phonePhotoError = nil
    }

}
