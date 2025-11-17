//
//  CordlessHandsetCharger.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 6/28/23.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

// MARK: - Imports

import SheftAppsStylishUI
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

    // MARK: - Properties - Transient (Non-Persistent) Properties

    // The actual number of this charger, which is handsetNumber (the index of the charger) + 1.
    @Transient
    var actualChargerNumber: Int {
        return chargerNumber + 1
    }

    // MARK: - Properties - Color Bindings

    var mainColorBinding: Binding<Color> {
        Color.rgbBinding(get: { [self] in (mainColorRed, mainColorGreen, mainColorBlue) }, set: { [self] r, g, b in
            mainColorRed = r
            mainColorGreen = g
            mainColorBlue = b
        })
    }
    
    var secondaryColorBinding: Binding<Color> {
        Color.rgbBinding(get: { [self] in (secondaryColorRed, secondaryColorGreen, secondaryColorBlue) }, set: { [self] r, g, b in
            secondaryColorRed = r
            secondaryColorGreen = g
            secondaryColorBlue = b
        })
    }

    @Transient
    var accentColorBinding: Binding<Color> {
        Color.rgbBinding(get: { [self] in (accentColorRed, accentColorGreen, accentColorBlue) }, set: { [self] r, g, b in
            accentColorRed = r
            accentColorGreen = g
            accentColorBlue = b
        })
    }

    @Transient
    var chargeLightColorChargingBinding: Binding<Color> {
        Color.rgbBinding(get: { [self] in (chargeLightColorChargingRed, chargeLightColorChargingGreen, chargeLightColorChargingBlue) }, set: { [self] r, g, b in
            chargeLightColorChargingRed = r
            chargeLightColorChargingGreen = g
            chargeLightColorChargingBlue = b
        })
    }

    @Transient
    var chargeLightColorChargedBinding: Binding<Color> {
        Color.rgbaQuantizedAlphaBinding(get: { [self] in (chargeLightColorChargedRed, chargeLightColorChargedGreen, chargeLightColorChargedBlue, chargeLightColorChargedAlpha) }, set: { [self] r, g, b, a in
            chargeLightColorChargedRed = r
            chargeLightColorChargedGreen = g
            chargeLightColorChargedBlue = b
            chargeLightColorChargedAlpha = a
        })
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
        let newCharger = CordlessHandsetCharger(
            mainColorRed: mainColorRed,
            mainColorGreen: mainColorGreen,
            mainColorBlue: mainColorBlue,
            secondaryColorRed: secondaryColorRed,
            secondaryColorGreen: secondaryColorGreen,
            secondaryColorBlue: secondaryColorBlue,
            accentColorRed: accentColorRed,
            accentColorGreen: accentColorGreen,
            accentColorBlue: accentColorBlue
        )
        // 2. Give the duplicated charger a new UUID.
        newCharger.id = UUID()
        // 3. Copy all other persistent properties (those not marked @Transient).
        newCharger.phone = self.phone
        newCharger.chargerNumber = self.chargerNumber
        newCharger.chargeLightColorChargingRed = self.chargeLightColorChargingRed
        newCharger.chargeLightColorChargingGreen = self.chargeLightColorChargingGreen
        newCharger.chargeLightColorChargingBlue = self.chargeLightColorChargingBlue
        newCharger.chargeLightColorChargedRed = self.chargeLightColorChargedRed
        newCharger.chargeLightColorChargedGreen = self.chargeLightColorChargedGreen
        newCharger.chargeLightColorChargedBlue = self.chargeLightColorChargedBlue
        newCharger.chargeLightColorChargedAlpha = self.chargeLightColorChargedAlpha
        newCharger.hasChargeLight = self.hasChargeLight
        newCharger.chargingDirection = self.chargingDirection
        newCharger.chargeContactPlacement = self.chargeContactPlacement
        newCharger.chargeContactType = self.chargeContactType
        newCharger.hasRangeExtender = self.hasRangeExtender
        newCharger.hasClockRadioAlarm = self.hasClockRadioAlarm
        newCharger.wallMountability = self.wallMountability
        newCharger.type = self.type
        newCharger.hasHardWiredACAdaptor = self.hasHardWiredACAdaptor
        // 4. Return the duplicated charger.
        return newCharger
    }

}
