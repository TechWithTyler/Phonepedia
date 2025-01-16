//
//  CordlessHandsetCharger.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 6/28/23.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SwiftData

@Model
final class CordlessHandsetCharger {
    
    // MARK: - Properties - Persistent Data

	var phone: Phone?
    
    var id = UUID()

    var mainColorRed: Double = 0

    var mainColorGreen: Double = 0

    var mainColorBlue: Double = 0

    var secondaryColorRed: Double = 0

    var secondaryColorGreen: Double = 0

    var secondaryColorBlue: Double = 0

    var accentColorRed: Double = 0

    var accentColorGreen: Double = 0

    var accentColorBlue: Double = 0

	var chargingDirection: Int = 0

	var chargeContactPlacement: Int = 0

	var chargeContactType: Int = 1

	var hasRangeExtender: Bool = false

	var wallMountability: Int = 0

    var type: Int = 0

    var hasHardWiredACAdaptor: Bool = false

    // MARK: - Properties - Color Bindings

    var mainColorBinding: Binding<Color> {
        Binding<Color> { [self] in
            Color(red: mainColorRed, green: mainColorGreen, blue: mainColorBlue)
        } set: { [self] newColor in
            let components = newColor.components
            mainColorRed = components.red
            mainColorGreen = components.green
            mainColorBlue = components.blue
        }
    }
    
    var secondaryColorBinding: Binding<Color> {
        Binding<Color> { [self] in
            Color(red: secondaryColorRed, green: secondaryColorGreen, blue: secondaryColorBlue)
        } set: { [self] newColor in
            let components = newColor.components
            secondaryColorRed = components.red
            secondaryColorGreen = components.green
            secondaryColorBlue = components.blue
        }
    }

    @Transient
    var accentColorBinding: Binding<Color> {
        Binding<Color> { [self] in
            Color(red: accentColorRed, green: accentColorGreen, blue: accentColorBlue)
        } set: { [self] newColor in
            let components = newColor.components
            accentColorRed = components.red
            accentColorGreen = components.green
            accentColorBlue = components.blue
        }
    }

    // MARK: - Initialization

    init(mainColorRed: Double, mainColorGreen: Double, mainColorBlue: Double, secondaryColorRed: Double, secondaryColorGreen: Double, secondaryColorBlue: Double, accentColorRed: Double, accentColorGreen: Double, accentColorBlue: Double) {
        self.mainColorRed = mainColorRed
        self.mainColorGreen = mainColorGreen
        self.mainColorBlue = mainColorBlue
        self.secondaryColorRed = secondaryColorRed
        self.secondaryColorGreen = secondaryColorGreen
        self.secondaryColorBlue = secondaryColorBlue
        self.accentColorRed = accentColorRed
        self.accentColorGreen = accentColorGreen
        self.accentColorBlue = accentColorBlue
    }

    // MARK: - Set Secondary Color to Main
    
    func setSecondaryColorToMain() {
        let components = mainColorBinding.wrappedValue.components
        secondaryColorRed = components.red
        secondaryColorGreen = components.green
        secondaryColorBlue = components.blue
    }

    // MARK: - Set Accent Color

    func setAccentColorToMain() {
        let components = mainColorBinding.wrappedValue.components
        accentColorRed = components.red
        accentColorGreen = components.green
        accentColorBlue = components.blue
    }

    func setAccentColorToSecondary() {
        let components = secondaryColorBinding.wrappedValue.components
        accentColorRed = components.red
        accentColorGreen = components.green
        accentColorBlue = components.blue
    }

    // MARK: - Duplicate

    func duplicate() -> CordlessHandsetCharger {
        // 1. Initialize a new CordlessHandsetCharger, passing the original's properties to the initializer.
        let newCharger = CordlessHandsetCharger(mainColorRed: mainColorRed, mainColorGreen: mainColorGreen, mainColorBlue: mainColorBlue, secondaryColorRed: secondaryColorRed, secondaryColorGreen: secondaryColorGreen, secondaryColorBlue: secondaryColorBlue, accentColorRed: accentColorRed, accentColorGreen: accentColorGreen, accentColorBlue: accentColorBlue)
        // 2. Give the duplicated handset a new UUID.
        newCharger.id = UUID()
        // 3. Copy all other properties.
        newCharger.phone = phone
        newCharger.hasRangeExtender = hasRangeExtender
        newCharger.wallMountability = wallMountability
        newCharger.chargeContactType = chargeContactType
        newCharger.chargeContactPlacement = chargeContactPlacement
        newCharger.chargingDirection = chargingDirection
        return newCharger
    }

}
