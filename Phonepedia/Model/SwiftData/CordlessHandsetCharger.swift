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

    var chargerNumber: Int = 0

    var mainColorRed: Double = 0

    var mainColorGreen: Double = 0

    var mainColorBlue: Double = 0

    var secondaryColorRed: Double = 0

    var secondaryColorGreen: Double = 0

    var secondaryColorBlue: Double = 0

    var accentColorRed: Double = 0

    var accentColorGreen: Double = 0

    var accentColorBlue: Double = 0

    var chargeLightColorChargingRed: Double = 255

    var chargeLightColorChargingGreen: Double = 0

    var chargeLightColorChargingBlue: Double = 0

    var chargeLightColorChargedRed: Double = 0

    var chargeLightColorChargedGreen: Double = 255

    var chargeLightColorChargedBlue: Double = 0

    var chargeLightColorChargedAlpha: Double = 1

    var hasChargeLight: Bool = false

	var chargingDirection: Int = 0

	var chargeContactPlacement: Int = 0

	var chargeContactType: Int = 1

	var hasRangeExtender: Bool = false

    var hasClockRadioAlarm: Bool = false

	var wallMountability: Int = 0

    var type: Int = 0

    var hasHardWiredACAdaptor: Bool = false

    // MARK: - Properties - Color Bindings

    var mainColorBinding: Binding<Color> {
        rgbBinding(
            get: { (self.mainColorRed, self.mainColorGreen, self.mainColorBlue) },
            set: { red, green, blue in
                self.mainColorRed = red
                self.mainColorGreen = green
                self.mainColorBlue = blue
            }
        )
    }
    
    var secondaryColorBinding: Binding<Color> {
        rgbBinding(
            get: { (self.secondaryColorRed, self.secondaryColorGreen, self.secondaryColorBlue) },
            set: { red, green, blue in
                self.secondaryColorRed = red
                self.secondaryColorGreen = green
                self.secondaryColorBlue = blue
            }
        )
    }

    @Transient
    var accentColorBinding: Binding<Color> {
        rgbBinding(
            get: { (self.accentColorRed, self.accentColorGreen, self.accentColorBlue) },
            set: { red, green, blue in
                self.accentColorRed = red
                self.accentColorGreen = green
                self.accentColorBlue = blue
            }
        )
    }

    @Transient
    var chargeLightColorChargingBinding: Binding<Color> {
        rgbBinding(
            get: { (self.chargeLightColorChargingRed, self.chargeLightColorChargingGreen, self.chargeLightColorChargingBlue) },
            set: { red, green, blue in
                self.chargeLightColorChargingRed = red
                self.chargeLightColorChargingGreen = green
                self.chargeLightColorChargingBlue = blue
            }
        )
    }

    @Transient
    var chargeLightColorChargedBinding: Binding<Color> {
        rgbaBinding(
            get: { (self.chargeLightColorChargedRed, self.chargeLightColorChargedGreen, self.chargeLightColorChargedBlue, Double(Int(self.chargeLightColorChargedAlpha.rounded(.toNearestOrEven)))) },
            set: { red, green, blue, alpha in
                self.chargeLightColorChargedRed = red
                self.chargeLightColorChargedGreen = green
                self.chargeLightColorChargedBlue = blue
                self.chargeLightColorChargedAlpha = Double(Int(alpha.rounded(.toNearestOrEven)))
            }
        )
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

    func setChargeLightChargedColorToCharging() {
        let components = chargeLightColorChargingBinding.wrappedValue.components
        chargeLightColorChargedRed = components.red
        chargeLightColorChargedGreen = components.green
        chargeLightColorChargedBlue = components.blue
        chargeLightColorChargedAlpha = 1
    }

    // MARK: - Duplicate

    func duplicate() -> CordlessHandsetCharger {
        // 1. Initialize a new CordlessHandsetCharger, passing the original's properties to the initializer.
        let newCharger = CordlessHandsetCharger(mainColorRed: mainColorRed, mainColorGreen: mainColorGreen, mainColorBlue: mainColorBlue, secondaryColorRed: secondaryColorRed, secondaryColorGreen: secondaryColorGreen, secondaryColorBlue: secondaryColorBlue, accentColorRed: accentColorRed, accentColorGreen: accentColorGreen, accentColorBlue: accentColorBlue)
        // 2. Give the duplicated charger a new UUID.
        newCharger.id = UUID()
        // 3. Copy all other properties.
        newCharger.phone = phone
        newCharger.hasRangeExtender = hasRangeExtender
        newCharger.wallMountability = wallMountability
        newCharger.chargeContactType = chargeContactType
        newCharger.chargeContactPlacement = chargeContactPlacement
        newCharger.chargingDirection = chargingDirection
        newCharger.chargeLightColorChargingRed = self.chargeLightColorChargingRed
        newCharger.chargeLightColorChargingGreen = self.chargeLightColorChargingGreen
        newCharger.chargeLightColorChargingBlue = self.chargeLightColorChargingBlue
        newCharger.chargeLightColorChargedRed = self.chargeLightColorChargedRed
        newCharger.chargeLightColorChargedGreen = self.chargeLightColorChargedGreen
        newCharger.chargeLightColorChargedBlue = self.chargeLightColorChargedBlue
        newCharger.chargeLightColorChargedAlpha = self.chargeLightColorChargedAlpha
        newCharger.hasChargeLight = self.hasChargeLight
        newCharger.hasHardWiredACAdaptor = self.hasHardWiredACAdaptor
        newCharger.type = self.type
        newCharger.hasClockRadioAlarm = self.hasClockRadioAlarm
        return newCharger
    }

}
