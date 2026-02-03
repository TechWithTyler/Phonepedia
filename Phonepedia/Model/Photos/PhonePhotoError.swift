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

    // Too many photos were dropped on a phone's photo.
    case tooManyPhotos(count: Int)

    // No photo data from PhotosPickerItem.
    case noPhotoDataPhotoPicker

    // No photo data from dropped item.
    case noPhotoDataDrop

    // Image prediction failed.
    case predictionFailed(reason: String)

    // Photo export failed.
    case exportFailed(reason: String)

    // MARK: - Error Description

    var errorDescription: String? {
        switch self {
        case .loadFailed(let error):
            return "(Bee-bee-beep) We're sorry, your photo can't be loaded. Please try again later. \(error.localizedDescription)"
        case .tooManyPhotos(let count):
            return "Only 1 photo can be imported. You attempted to import \(count) photos."
        case .noPhotoDataPhotoPicker:
            return "Photo picker selection contained no photo data."
        case .noPhotoDataDrop:
            return "Dropped item contained no photo data."
        case .predictionFailed(let reason):
            return "Image prediction failed: \(reason)"
        case .exportFailed(let reason):
            return "Photo export failed: \(reason)"
        }
    }
    
}
