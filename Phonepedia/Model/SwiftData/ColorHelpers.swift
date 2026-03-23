//
//  ColorHelpers.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 11/13/25.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SheftAppsStylishUI

// MARK: - Color Manipulation Protocols/Extensions

// Protocol for types that store colors as separate RGB component properties and need basic color manipulation helpers.
protocol BaseColorManipulatable: AnyObject {

    var mainColorRed: Double { get set }

    var mainColorGreen: Double { get set }

    var mainColorBlue: Double { get set }

    var secondaryColorRed: Double { get set }

    var secondaryColorGreen: Double { get set }

    var secondaryColorBlue: Double { get set }

    var accentColorRed: Double { get set }

    var accentColorGreen: Double { get set }

    var accentColorBlue: Double { get set }

    var mainColorBinding: Binding<Color> { get }

    var secondaryColorBinding: Binding<Color> { get }

    var accentColorBinding: Binding<Color> { get }

}

// To define a method that all conforming types have access to, without having to implement them, it must be declared in an extension to the protocol.
extension BaseColorManipulatable {

    // This method copies the main color components to the secondary color.
    func setSecondaryColorToMain() {
        let components = mainColorBinding.wrappedValue.components
        secondaryColorRed = components.red
        secondaryColorGreen = components.green
        secondaryColorBlue = components.blue
    }

    // This method copies the main color components to the accent color.
    func setAccentColorToMain() {
        let components = mainColorBinding.wrappedValue.components
        accentColorRed = components.red
        accentColorGreen = components.green
        accentColorBlue = components.blue
    }

    // This method copies the secondary color components to the accent color.
    func setAccentColorToSecondary() {
        let components = secondaryColorBinding.wrappedValue.components
        accentColorRed = components.red
        accentColorGreen = components.green
        accentColorBlue = components.blue
    }

}

// Protocol for types that have charge light colors and need manipulation helpers.
protocol ChargeLightColorManipulatable: AnyObject {

    var chargeLightColorChargingRed: Double { get set }

    var chargeLightColorChargingGreen: Double { get set }

    var chargeLightColorChargingBlue: Double { get set }

    var chargeLightColorChargedRed: Double { get set }

    var chargeLightColorChargedGreen: Double { get set }

    var chargeLightColorChargedBlue: Double { get set }

    var chargeLightColorChargedAlpha: Double { get set }

    var chargeLightColorChargingBinding: Binding<Color> { get }

    var chargeLightColorChargedBinding: Binding<Color> { get }

}

extension ChargeLightColorManipulatable {

    // This method copies the charging color components to the charged color and sets alpha to 1.
    func setChargeLightChargedColorToCharging() {
        let components = chargeLightColorChargingBinding.wrappedValue.components
        chargeLightColorChargedRed = components.red
        chargeLightColorChargedGreen = components.green
        chargeLightColorChargedBlue = components.blue
        chargeLightColorChargedAlpha = 1
    }

}

// Protocol for types that have corded receiver colors and need manipulation helpers.
protocol CordedReceiverColorManipulatable: AnyObject {

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

    // This method copies the corded receiver main color components to the secondary color.
    func setCordedReceiverSecondaryColorToMain() {
        let components = cordedReceiverMainColorBinding.wrappedValue.components
        cordedReceiverSecondaryColorRed = components.red
        cordedReceiverSecondaryColorGreen = components.green
        cordedReceiverSecondaryColorBlue = components.blue
    }

    // This method copies the corded receiver main color components to the accent color.
    func setCordedReceiverAccentColorToMain() {
        let components = cordedReceiverMainColorBinding.wrappedValue.components
        cordedReceiverAccentColorRed = components.red
        cordedReceiverAccentColorGreen = components.green
        cordedReceiverAccentColorBlue = components.blue
    }

    // This method copies the corded receiver secondary color components to the accent color.
    func setCordedReceiverAccentColorToSecondary() {
        let components = cordedReceiverSecondaryColorBinding.wrappedValue.components
        cordedReceiverAccentColorRed = components.red
        cordedReceiverAccentColorGreen = components.green
        cordedReceiverAccentColorBlue = components.blue
    }

}

// Protocol for types that have key foreground/background colors and need to swap them.
protocol KeyColorManipulatable: AnyObject {

    var keyBackgroundColorRed: Double { get set }

    var keyBackgroundColorGreen: Double { get set }

    var keyBackgroundColorBlue: Double { get set }

    var keyForegroundColorRed: Double { get set }

    var keyForegroundColorGreen: Double { get set }

    var keyForegroundColorBlue: Double { get set }

}

extension KeyColorManipulatable {

    // This method swaps the key background and foreground color components.
    func swapKeyBackgroundAndForegroundColors() {
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
