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

    #if !os(macOS)
    case cameraError
    #endif

    // Photo loading failed.
    case loadFailed(error: Error)

    // Too many photos were dropped on a phone's photo.
    case tooManyPhotos(count: Int)

    // No photo data from PhotosPickerItem.
    case noPhotoDataPhotoPicker

    // No photo data from dropped item.
    case noPhotoDataDrop

    // Photo export failed.
    case exportFailed(reason: String)

    // Image for prediction had no data.
    case noImageForPrediction

    // No underlying CGImage for image prediction
    case noUnderlyingImageForPrediction

    // Failed to create image prediction request
    case predictionRequestFailed

    // Prediction request had no results.
    case predictionNoResults

    // Prediction produced the wrong result type.
    case predictionWrongResultType(resultType: Any.Type)

    // Unknown prediction failure with the given reason.
    case unknownPredictionFailure(reason: String)

    // MARK: - Error Description

    var errorDescription: String? {
        switch self {
            #if !os(macOS)
        case .cameraError:
            return "Camera error."
            #endif
        case .loadFailed(let error):
            return "(Bee-bee-beep) We're sorry, your photo can't be loaded. Please try again later. \(error.localizedDescription)"
        case .tooManyPhotos(let count):
            return "Only 1 photo can be imported. You attempted to import \(count) photos."
        case .noPhotoDataPhotoPicker:
            return "Photo picker selection contained no photo data."
        case .noPhotoDataDrop:
            return "Dropped item contained no photo data."
        case .unknownPredictionFailure(let reason):
            return "Image prediction failed: \(reason)"
        case .predictionRequestFailed:
            return "Failed to create an image classification request."
        case .predictionNoResults:
            return "Vision request had no results."
        case .predictionWrongResultType(let resultType):
            return "VNRequest produced the wrong result type: \(resultType)."
        case .noImageForPrediction:
            return "Failed to create image from data."
        case .noUnderlyingImageForPrediction:
            return "No underlying CGImage for image prediction."
        case .exportFailed(let reason):
            return "Photo export failed: \(reason)"
        }
    }
    
}
