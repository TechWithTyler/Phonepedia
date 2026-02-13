//
//  CGImagePropertyOrientationExtension.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 12/20/23.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI

#if !os(macOS)
extension CGImagePropertyOrientation {

    // MARK: - Initialization

    // Converts a UIImage orientation to a Core Graphics image property orientation. The two orientation types use different raw values.
    init(_ orientation: UIImage.Orientation) {
        switch orientation {
            case .up: self = .up
            case .down: self = .down
            case .left: self = .left
            case .right: self = .right
            case .upMirrored: self = .upMirrored
            case .downMirrored: self = .downMirrored
            case .leftMirrored: self = .leftMirrored
            case .rightMirrored: self = .rightMirrored
            default: self = .up
        }
    }
    
}
#endif
