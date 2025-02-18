//
//  Wave.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 2/29/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI

struct Wave: Shape {

    var frequency: Phone.CordlessFrequency

    var phase: CGFloat

    var animatableData: CGFloat {
        get { phase }
        set { phase = newValue }
    }

    func path(in rect: CGRect) -> Path {
        // 1. Define the wave amplitude (height stays constant).
        let strength: CGFloat = 50
        let width = rect.width
        let height = rect.height
        let midHeight = height / 2
        // 2. Convert frequency (MHz) to Hz.
        // This number is written normally. Underscores can be used to make the number easier to read.
        let frequencyHz: CGFloat = frequency.waveFrequency * 1_000_000
        // 3. Convert to lowest frequency in Hz (scientific notation). This number is written using the pow(_:_:) method, where the first number is the base and the second number is the exponent.
        let lowestFrequencyHz: CGFloat = 1.7 * Double(pow(10, 6))
        // 4. Convert to highest frequency in Hz (scientific notation). This number is written using XeY, where X represents the number and Y represents powers of 10.
        let highestFrequencyHz: CGFloat = 5800e6
        // 5. Dynamically calculate wavelength based on frequency.
        // Use a scaling factor to ensure wavelength fits within the view.
        let minWavelength: CGFloat = width / 5  // Minimum wavelength for the highest frequencies (more compressed)
        let maxWavelength: CGFloat = width  // Maximum wavelength for the lowest frequencies (more stretched)
        // 6. Calculate the scaled wavelength. Lower frequencies will result in larger wavelengths.
        let scaledWavelength = maxWavelength - ((maxWavelength - minWavelength) * (log(frequencyHz) - log(lowestFrequencyHz)) / (log(highestFrequencyHz) - log(lowestFrequencyHz)))
        // 7. Step size for smooth wave drawing.
        let stepSize = max(1.0, scaledWavelength / 40)
        // 8. Create a path.
        var path = Path()
        // 9. Draw the center horizontal line.
        path.move(to: CGPoint(x: 0, y: midHeight))
        path.addLine(to: CGPoint(x: width, y: midHeight))
        // 10. Draw the sine wave.
        var firstPointSet = false
        for x in stride(from: 0, through: width, by: stepSize) {
            let relativeX = (x / scaledWavelength) + phase
            let sineValue = sin(relativeX * .pi * 2)
            let adjustedY = sineValue * strength
            let point = CGPoint(x: x, y: midHeight + adjustedY)
            if !firstPointSet {
                // 11. Start at the first point.
                path.move(to: point)
                firstPointSet = true
            } else {
                // 12. Continue the wave smoothly.
                path.addLine(to: point)
            }
        }
        // 13. Return the generated path.
        return path
    }

    
}


#Preview {
    Wave(frequency: .analog1_7MHz, phase: 0)
        .stroke(lineWidth: 1)
}
