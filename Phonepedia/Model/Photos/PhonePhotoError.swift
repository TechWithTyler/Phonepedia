//
//  PhonePhotoError.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 12/11/23.
//

// MARK: - Imports

import Foundation

enum PhonePhotoError: LocalizedError {

    // MARK: - Error Cases

    // Photo loading failed.
    case loadFailed(error: Error)

    // No photo data from PhotosPickerItem.
    case noPhotoData

    // Image prediction failed.
    case predictionFailed(reason: String)

    // Photo export failed.
    case exportFailed(reason: String)

    // A file that isn't an image was dropped on a phone's photo for import.
    case droppedNonImage

    // MARK: - Error Description

    var errorDescription: String? {
        switch self {
        case .loadFailed(let error):
            return "(Bee-bee-beep) We're sorry, your photo can't be loaded. Please try again later. \(error.localizedDescription)"
        case .noPhotoData:
            return "Photo picker selection contained no photo data."
        case .predictionFailed(let reason):
            return "Image prediction failed: \(reason)"
        case .exportFailed(let reason):
            return "Photo export failed: \(reason)"
        case .droppedNonImage:
            return "(Bee-bee-beep) This file isn't an image. Please try again with an image file."
        }
    }
    
}
