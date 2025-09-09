//
//  PhonePhotoError.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 12/11/23.
//

import Foundation

enum PhonePhotoError: LocalizedError {
    
    case loadFailed(error: Error)

    case predictionFailed(reason: String)

    case exportFailed(reason: String)

    case droppedNonImage

    var errorDescription: String? {
        switch self {
        case .loadFailed(let error):
            return "(Bee-bee-beep) We're sorry, your photo can't be loaded. Please try again later. \(error.localizedDescription)"
        case .predictionFailed(let reason):
            return "Prediction failed: \(reason)"
        case .exportFailed(let reason):
            return "Export failed: \(reason)"
        case .droppedNonImage:
            return "(Bee-bee-beep) This file isn't an image. Please try again with an image file."
        }
    }
    
}
