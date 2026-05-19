//
//  CordlessHandsetCharger.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 6/28/23.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SheftAppsStylishUI
import SwiftData

@Model
final class CordlessHandsetCharger: BaseHandsetChargerColorManipulatable, ChargeLightColorManipulatable {
    
    // MARK: - Properties - Persistent Data

    // The ID of the charger.
    var id = UUID()

    // The phone this charger is assigned to.
    var phone: Phone?

    // The index of the charger.
    var chargerNumber: Int = 0

    // The main color's red component.
    var mainColorRed: Double = 0

    // The main color's green component.
    var mainColorGreen: Double = 0

    // The main color's blue component.
    var mainColorBlue: Double = 0

    // The secondary color's red component.
    var secondaryColorRed: Double = 0

    // The secondary color's green component.
    var secondaryColorGreen: Double = 0

    // The secondary color's blue component.
    var secondaryColorBlue: Double = 0

    // The accent color's red component.
    var accentColorRed: Double = 0

    // The accent color's green component.
    var accentColorGreen: Double = 0

    // The accent color's blue component.
    var accentColorBlue: Double = 0

    // The charge light charging state color's red component.
    var chargeLightColorChargingRed: Double = 255

    // The charge light charging state color's green component.
    var chargeLightColorChargingGreen: Double = 0

    // The charge light charging state color's blue component.
    var chargeLightColorChargingBlue: Double = 0

    // The charge light charged state color's red component.
    var chargeLightColorChargedRed: Double = 0

    // The charge light charged state color's green component.
    var chargeLightColorChargedGreen: Double = 255

    // The charge light charged state color's blue component.
    var chargeLightColorChargedBlue: Double = 0

    // The charge light charged state color's alpha component.
    var chargeLightColorChargedAlpha: Double = 1

    // Whether the charger has a charge light.
    var hasChargeLight: Bool = false

    // The direction the handset charges.
	var chargingDirection: Int = 0

    // The placement of the charging contacts.
	var chargeContactPlacement: Int = 0

    // The charging contact type.
	var chargeContactType: Int = 1

    // Whether the charger has a built-in range extender.
	var hasRangeExtender: Bool = false

    // Whether the charger has a clock/radio/alarm.
    var hasClockRadioAlarm: Bool = false

    // Whether the charger can be wall-mounted. 0 = not supported, 1 = holes on back, 2 = optional bracket.
	var wallMountability: Int = 0

    // The cordless device the charger charges. 0 = handset, 1 = headset/speakerphone.
    var type: Int = 0

    // Whether the AC adaptor is hard-wired (non-removable).
    var hasHardWiredACAdaptor: Bool = false

    // MARK: - Properties - Transient (Non-Persistent) Properties

    // The actual number of the charger, which is chargerNumber (the index of the charger) + 1.
    @Transient
    var actualChargerNumber: Int {
        return chargerNumber + 1
    }

    // Whether the charger has a secondary color (the main and secondary colors aren't the same).
    @Transient
    var hasSecondaryColor: Bool {
        return secondaryColorBinding.wrappedValue != mainColorBinding.wrappedValue
    }

    // Whether the charger has an accent color (the accent color is different from both the main and secondary colors).
    @Transient
    var hasAccentColor: Bool {
        return accentColorBinding.wrappedValue != mainColorBinding.wrappedValue && accentColorBinding.wrappedValue != secondaryColorBinding.wrappedValue
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

    // MARK: - Duplicate

    // This method duplicates the charger.
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
