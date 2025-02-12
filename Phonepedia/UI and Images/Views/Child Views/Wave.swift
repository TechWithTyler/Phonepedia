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

    func path(in rect: CGRect) -> Path {
        // 1. Define the amplitude of the wave, controlling wave height
        let strength: Double = 50

        // 2. Get the width of the available drawing area
        let width = Double(rect.width)

        // 3. Get the height of the available drawing area
        let height = Double(rect.height)

        // 4. Calculate the midpoint of the view height for wave centering
        let midHeight = height / 2

        // 5. Define the speed of light in meters per second
        let speedOfLight: Double = 299_792_458

        // 6. Convert the frequency from MHz to Hz
        let frequencyHz = frequency.rawValue * 1_000_000

        // 7. Calculate the wavelength in meters
        let wavelengthMeters = speedOfLight / frequencyHz

        // 8. Scale the wavelength to fit the view width properly
        let scaledWavelength = width * wavelengthMeters / 10

        // 9. Initialize a path to store the wave shape
        var path = Path()

        // 10. Start the wave at the left center of the view
        path.move(to: CGPoint(x: 0, y: midHeight))

        // 11. Loop through each x position from 0 to the width, stepping by 1 unit
        for x in stride(from: 0, through: width, by: 1) {
            // 12. Normalize the x value based on the wavelength
            let relativeX = x / scaledWavelength

            // 13. Compute the sine wave oscillation for the current position
            let sineValue = sin(relativeX * .pi * 2)

            // 14. Scale the oscillation to match the amplitude
            let adjustedY = sineValue * strength

            // 15. Position the wave vertically centered
            let y = midHeight + adjustedY

            // 16. Draw the wave segment
            path.addLine(to: CGPoint(x: x, y: y))
        }

        // 17. Return the final wave path
        return path
    }
}

#Preview {
    Wave(frequency: .northAmericaDECT6)
        .stroke(lineWidth: 1)
}
