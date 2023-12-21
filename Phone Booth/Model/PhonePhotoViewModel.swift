//
//  PhonePhotoViewModel.swift
//  Phone Booth
//
//  Created by Tyler Sheft on 12/19/23.
//  Copyright © 2023-2024 SheftApps. All rights reserved.
//

import SwiftUI
import PhotosUI
import Vision

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
    
    @Published var phonePhotoError: PhonePhotoError? = nil
    
    func updatePhonePhoto(for phone: Phone, oldValue: PhotosPickerItem?, newValue: PhotosPickerItem?) {
        guard let newValue = newValue else { return }
        let progress = newValue.loadTransferable(type: Data.self) { [self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async { [self] in
                    checkImageForLandlines(data!, phone: phone)
                }
            case .failure(let error as NSError):
                #if(DEBUG)
                print("Error: \(error)")
                #endif
                phonePhotoError = .loadFailed
                showingPhonePhotoErrorAlert = true
            }
        }
        progress.resume()
    }
    
    func checkImageForLandlines(_ photoData: Data, phone: Phone) {
        do {
            try imagePredictor.makePredictions(for: photoData, phone: phone, completionHandler: imagePredictionHandler)
        } catch {
            print("Vision was unable to make a prediction...\n\n\(error.localizedDescription)")
        }
    }
    
    private func imagePredictionHandler(_ predictions: [LandlineOrNotPredictor.Prediction]?, photoData: Data, phone: Phone) {
        guard let predictions = predictions, let firstPrediction = predictions.first else {
            phonePhotoError = .predictionFailed(reason: "No predictions available.")
            showingPhonePhotoErrorAlert = true
            return
        }
        if firstPrediction.isLandline {
            phone.photoData = photoData
        } else {
            unsurePhotoDataToUse = photoData
            showingUnsurePhotoDataAlert = true
        }
    }
    
}
