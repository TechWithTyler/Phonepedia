//
//  PhonePhotoError.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 12/11/23.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import Foundation

enum PhonePhotoError: LocalizedError {

    enum PhotoSource {

        case photoPicker

        case drop

    }

    // MARK: - Error Cases

    #if !os(macOS)
    case cameraError
    #endif

    // Photo loading failed.
    case loadFailed(error: Error)

    // Too many photos were dropped on a phone's photo.
    case tooManyPhotos(count: Int)

    // No photo data from the given source.
    case noPhotoData(source: PhotoSource)

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
            return "(Bee-bee-beep) We're sorry, your photo can't be loaded at this time. Please try again later. \(error.localizedDescription)"
        case .tooManyPhotos(let count):
            return "Only 1 photo can be imported. You attempted to import \(count) photos."
        case .noPhotoData(let source):
            return "\(source == .drop ? "Dropped item" : "Photo picker selection") contained no photo data."
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
