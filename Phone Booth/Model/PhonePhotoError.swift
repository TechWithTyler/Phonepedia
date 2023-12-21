//
//  PhonePhotoError.swift
//  Phone Booth
//
//  Created by Tyler Sheft on 12/11/23.
//

import Foundation

enum PhonePhotoError: LocalizedError {
    
    case loadFailed
    
    case predictionFailed(reason: String)
    
    var errorDescription: String? {
        switch self {
        case .loadFailed:
            return "(Bee-bee-beep) We're sorry, your photo can't be loaded. Please try again later."
        case .predictionFailed(let reason):
            return "Prediction failed: \(reason)"
        }
    }
    
}
