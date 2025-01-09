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
    
    var imagePredictor: LandlineOrNotPredictor {
        return LandlineOrNotPredictor(photoViewModel: self)
    }
    
    @Published var showingPhonePhotoErrorAlert: Bool = false
    
    @Published var showingUnsurePhotoDataAlert: Bool = false
    
    @Published var unsurePhotoDataToUse: Data? = nil
    
    @Published var selectedPhoto: PhotosPickerItem? = nil
    
#if os(iOS)
    @Published var takingPhoto: Bool = false
#endif
    
    @Published var showingPhotoPicker: Bool = false
    
    @Published var showingResetAlert: Bool = false

    @Published var showingLoadingPhoto: Bool = false

    @Published var phonePhotoError: PhonePhotoError? = nil
    
    func updatePhonePhoto(for phone: Phone, oldValue: PhotosPickerItem?, newValue: PhotosPickerItem?) {
        guard let newValue = newValue else { return }
        let progress = newValue.loadTransferable(type: Data.self) { [self] result in
            // 1. Nil-out the photo picker selection after it's loaded into the app.
            DispatchQueue.main.async { [self] in
                selectedPhoto = nil
                switch result {
                case .success(let data):
                    // 2. If successful, check the photo for landline phones. Ask the user for confirmation if no landline phones could be detected.
                    checkImageForLandlines(data!, phone: phone)
                case .failure(let error as NSError):
                    // 3. If photo loading fails, log an error.
#if(DEBUG)
                    print("Error: \(error)")
#endif
                    phonePhotoError = .loadFailed
                    showingPhonePhotoErrorAlert = true
                    showingLoadingPhoto = false
                }
            }
        }
        progress.resume()
        showingLoadingPhoto = true
    }
    
    func checkImageForLandlines(_ photoData: Data, phone: Phone) {
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
    
}
