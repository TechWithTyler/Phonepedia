//
//  Wave.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 2/29/24.
//  Copyright © 2023-2024 SheftApps. All rights reserved.
//

import SwiftUI

struct Wave: Shape {
    
    enum Frequency: Double {
        
        case lowMoreRange = 50
        
        case highLessRange = 100
    }

    var frequency: Frequency

    func path(in rect: CGRect) -> Path {
        let strength: Double = 50
        #if os(macOS)
        let path = NSBezierPath()
        #else
        let path = UIBezierPath()
        #endif
        // Calculate some important values up front
        let width = Double(rect.width)
        let height = Double(rect.height)
        let midHeight = height / 2
        // Split our total width based on the frequency
        let wavelength = width / frequency.rawValue
        // Start at the left center
        path.move(to: CGPoint(x: 0, y: midHeight))
        // Calculate the wave points
        for x in stride(from: 0, through: width, by: 1) {
            // Find our current position relative to the wavelength
            let relativeX = x / wavelength
            // Apply the sine function to get a value between -1 and 1
            let sineValue = sin(relativeX)
            // Multiply by the strength property to adjust wave height
            let adjustedY = sineValue * strength
            // Center the point vertically
            let y = midHeight + adjustedY
            // Add the point to the path
            #if os(macOS)
            path.line(to: CGPoint(x: x, y: y))
            #else
            path.addLine(to: CGPoint(x: x, y: y))
            #endif
        }
        return Path(path.cgPath)
    }
}

#Preview {
    Wave(frequency: .lowMoreRange)
        .stroke(lineWidth: 1)
}
