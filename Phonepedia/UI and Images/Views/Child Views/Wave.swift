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
        // 1. Define the strength of the wave.
        let strength: Double = 50
        // 2. Create a bezier path.
        #if os(macOS)
        let path = NSBezierPath()
        #else
        let path = UIBezierPath()
        #endif
        // 3. Calculate the mid height of the wave.
        let width = Double(rect.width)
        let height = Double(rect.height)
        let midHeight = height / 2
        // 4. Split the total width based on the frequency.
        let wavelength = width / frequency.rawValue
        // 5. Start at the left center.
        path.move(to: CGPoint(x: 0, y: midHeight))
        // 6. Calculate the wave points.
        for x in stride(from: 0, through: width, by: 1) {
            // 7. Find the current position relative to the wavelength.
            let relativeX = x / wavelength
            // 8. Apply the sine function to get a value between -1 and 1.
            let sineValue = sin(relativeX)
            // 9. Multiply by the strength property to adjust wave height.
            let adjustedY = sineValue * strength
            // 10. Center the point vertically.
            let y = midHeight + adjustedY
            // 11. Add the point to the path.
            #if os(macOS)
            path.line(to: CGPoint(x: x, y: y))
            #else
            path.addLine(to: CGPoint(x: x, y: y))
            #endif
        }
        // 12. Return the path.
        return Path(path.cgPath)
    }
}

#Preview {
    Wave(frequency: .lowMoreRange)
        .stroke(lineWidth: 1)
}
