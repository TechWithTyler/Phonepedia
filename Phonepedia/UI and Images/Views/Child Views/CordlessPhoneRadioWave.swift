//
//  CordlessPhoneRadioWave.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 2/29/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI

struct CordlessPhoneRadioWave: Shape {

    // The frequency of the wave.
    var frequency: Phone.CordlessFrequency

    // The wave animation phase.
    var phase: CGFloat

    // Gets and sets the phase property during animations.
    var animatableData: CGFloat {
        get { phase }
        set { phase = newValue }
    }

    // Draws a wave path in the given rectangle.
    func path(in rect: CGRect) -> Path {
        // 1. Define the wave amplitude (peak deviation from the center).
        let strength: CGFloat = 50
        let width = rect.width
        let height = rect.height
        // The vertical midpoint of the rectangle.
        let midHeight = height / 2
        // 2. Convert frequency from MHz to Hz by multiplying by 1,000,000.
        // This number is written normally, but underscores can be used to improve readability.
        let frequencyHz: CGFloat = frequency.waveFrequency * 1_000_000
        // 3. Define the lowest frequency in Hz using scientific notation.
        // This number is written using the pow(_:_:) method, where the first number is the base and the second number is the exponent.
        let lowestFrequencyHz: CGFloat = 1.7 * Double(pow(10, 6))  // 1.7 × 10^6 Hz (1.7MHz)
        // 4. Define the highest frequency in Hz using scientific notation.
        // This number is written using XeY notation, where X is the number and Y is the power of 10.
        let highestFrequencyHz: CGFloat = 5800e6  // 5.8 × 10⁹ Hz (5.8 GHz)
        // 5. Calculate the wavelength dynamically based on frequency.
        // Lower frequencies have longer wavelengths, making the wave appear stretched.
        // Higher frequencies have shorter wavelengths, making the wave more compressed.
        // Shortest wavelength (for highest frequency).
        let minWavelength: CGFloat = width / 5
        // Longest wavelength (for lowest frequency).
        let maxWavelength: CGFloat = width
        // 6. Compute the scaled wavelength using logarithmic interpolation.
        // Logarithmic scaling ensures smooth frequency-based wavelength adjustments.
        // Lower frequencies will result in larger wavelengths, which is why they have more range.
        let scaledWavelength = maxWavelength - ((maxWavelength - minWavelength) * (log(frequencyHz) - log(lowestFrequencyHz)) / (log(highestFrequencyHz) - log(lowestFrequencyHz)))
        // 7. Define the step size for plotting the wave, ensuring smooth rendering (at least 1 pixel for finer detail).
        let stepSize = max(1.0, scaledWavelength / 40)
        // 8. Initialize a new path for drawing.
        var path = Path()
        // 9. Draw a center horizontal baseline as a reference.
        path.move(to: CGPoint(x: 0, y: midHeight))
        path.addLine(to: CGPoint(x: width, y: midHeight))
        // 10. Iterate over x-coordinates to plot the sine wave.
        var firstPointSet = false
        for x in stride(from: 0, through: width, by: stepSize) {
            // 11. Calculate the sine wave value at each x position.
            // relativeX shifts the wave based on phase.
            let relativeX = (x / scaledWavelength) + phase
            // Convert to sine wave oscillation.
            let sineValue = sin(relativeX * .pi * 2)
            // Scale by amplitude.
            let adjustedY = sineValue * strength
            // Position relative to center.
            let point = CGPoint(x: x, y: midHeight + adjustedY)
            if !firstPointSet {
                // 12. Move to the first point of the wave.
                path.move(to: point)
                firstPointSet = true
            } else {
                // 13. Connect the points to form a continuous wave.
                path.addLine(to: point)
            }
        }
        // 14. Return the completed wave path.
        return path
    }


    
}


#Preview {
    CordlessPhoneRadioWave(frequency: .analog1_7MHz, phase: 0)
        .stroke(lineWidth: 1)
}
