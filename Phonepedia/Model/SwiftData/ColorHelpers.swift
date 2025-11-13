//
//  ColorHelpers.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 11/13/25.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SheftAppsStylishUI

// MARK: - Color Manipulation Protocols

// Protocol for types that store colors as separate RGB component properties and need basic color manipulation helpers.
protocol BaseColorManipulatable {

    // Required: The color component storage properties
    var mainColorRed: Double { get set }

    var mainColorGreen: Double { get set }

    var mainColorBlue: Double { get set }

    var secondaryColorRed: Double { get set }

    var secondaryColorGreen: Double { get set }

    var secondaryColorBlue: Double { get set }

    var accentColorRed: Double { get set }

    var accentColorGreen: Double { get set }

    var accentColorBlue: Double { get set }

    // Required: The color bindings (using Color.rgbBinding from SheftAppsStylishUI)
    var mainColorBinding: Binding<Color> { get }

    var secondaryColorBinding: Binding<Color> { get }

    var accentColorBinding: Binding<Color> { get }

}

extension BaseColorManipulatable {

    // Copies the main color components to the secondary color.
    mutating func setSecondaryColorToMain() {
        let components = mainColorBinding.wrappedValue.components
        secondaryColorRed = components.red
        secondaryColorGreen = components.green
        secondaryColorBlue = components.blue
    }

    // Copies the main color components to the accent color.
    mutating func setAccentColorToMain() {
        let components = mainColorBinding.wrappedValue.components
        accentColorRed = components.red
        accentColorGreen = components.green
        accentColorBlue = components.blue
    }

    // Copies the secondary color components to the accent color.
    mutating func setAccentColorToSecondary() {
        let components = secondaryColorBinding.wrappedValue.components
        accentColorRed = components.red
        accentColorGreen = components.green
        accentColorBlue = components.blue
    }

}

// Protocol for types that have charge light colors and need manipulation helpers.
protocol ChargeLightColorManipulatable {

    // Required: Charge light color component storage properties
    var chargeLightColorChargingRed: Double { get set }

    var chargeLightColorChargingGreen: Double { get set }

    var chargeLightColorChargingBlue: Double { get set }

    var chargeLightColorChargedRed: Double { get set }

    var chargeLightColorChargedGreen: Double { get set }

    var chargeLightColorChargedBlue: Double { get set }

    var chargeLightColorChargedAlpha: Double { get set }

    // Required: The charging color binding
    var chargeLightColorChargingBinding: Binding<Color> { get }

}

extension ChargeLightColorManipulatable {

    // Copies the charging color components to the charged color and sets alpha to 1.
    mutating func setChargeLightChargedColorToCharging() {
        let components = chargeLightColorChargingBinding.wrappedValue.components
        chargeLightColorChargedRed = components.red
        chargeLightColorChargedGreen = components.green
        chargeLightColorChargedBlue = components.blue
        chargeLightColorChargedAlpha = 1
    }

}

// Protocol for types that have corded receiver colors and need manipulation helpers.
protocol CordedReceiverColorManipulatable {

    // Required: Corded receiver color component storage properties
    var cordedReceiverMainColorRed: Double { get set }

    var cordedReceiverMainColorGreen: Double { get set }

    var cordedReceiverMainColorBlue: Double { get set }

    var cordedReceiverSecondaryColorRed: Double { get set }

    var cordedReceiverSecondaryColorGreen: Double { get set }

    var cordedReceiverSecondaryColorBlue: Double { get set }

    var cordedReceiverAccentColorRed: Double { get set }

    var cordedReceiverAccentColorGreen: Double { get set }

    var cordedReceiverAccentColorBlue: Double { get set }

    // Required: The corded receiver color bindings
    var cordedReceiverMainColorBinding: Binding<Color> { get }

    var cordedReceiverSecondaryColorBinding: Binding<Color> { get }

}

extension CordedReceiverColorManipulatable {

    // Copies the corded receiver main color components to the secondary color.
    mutating func setCordedReceiverSecondaryColorToMain() {
        let components = cordedReceiverMainColorBinding.wrappedValue.components
        cordedReceiverSecondaryColorRed = components.red
        cordedReceiverSecondaryColorGreen = components.green
        cordedReceiverSecondaryColorBlue = components.blue
    }

    // Copies the corded receiver main color components to the accent color.
    mutating func setCordedReceiverAccentColorToMain() {
        let components = cordedReceiverMainColorBinding.wrappedValue.components
        cordedReceiverAccentColorRed = components.red
        cordedReceiverAccentColorGreen = components.green
        cordedReceiverAccentColorBlue = components.blue
    }

    // Copies the corded receiver secondary color components to the accent color.
    mutating func setCordedReceiverAccentColorToSecondary() {
        let components = cordedReceiverSecondaryColorBinding.wrappedValue.components
        cordedReceiverAccentColorRed = components.red
        cordedReceiverAccentColorGreen = components.green
        cordedReceiverAccentColorBlue = components.blue
    }

}

// Protocol for types that have key foreground/background colors and need to swap them.
protocol KeyColorManipulatable {

    // Required: Key color component storage properties
    var keyBackgroundColorRed: Double { get set }

    var keyBackgroundColorGreen: Double { get set }

    var keyBackgroundColorBlue: Double { get set }

    var keyForegroundColorRed: Double { get set }

    var keyForegroundColorGreen: Double { get set }

    var keyForegroundColorBlue: Double { get set }

}

extension KeyColorManipulatable {

    // Swaps the key background and foreground color components.
    mutating func swapKeyBackgroundAndForegroundColors() {
        let previousBackgroundRed = keyBackgroundColorRed
        let previousBackgroundGreen = keyBackgroundColorGreen
        let previousBackgroundBlue = keyBackgroundColorBlue
        keyBackgroundColorRed = keyForegroundColorRed
        keyBackgroundColorGreen = keyForegroundColorGreen
        keyBackgroundColorBlue = keyForegroundColorBlue
        keyForegroundColorRed = previousBackgroundRed
        keyForegroundColorGreen = previousBackgroundGreen
        keyForegroundColorBlue = previousBackgroundBlue
    }

}
