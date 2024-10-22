//
//  CordlessHandsetCharger.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 6/28/23.
//  Copyright © 2023-2024 SheftApps. All rights reserved.
//

import SwiftUI
import SwiftData

@Model
final class CordlessHandsetCharger {
    
    // MARK: - Properties

	var phone: Phone?
    
    var id = UUID()

    var mainColorRed: Double = 0
    
    var mainColorGreen: Double = 0
    
    var mainColorBlue: Double = 0
    
    var secondaryColorRed: Double = 0
    
    var secondaryColorGreen: Double = 0
    
    var secondaryColorBlue: Double = 0

	var chargingDirection: Int = 0

	var chargeContactPlacement: Int = 0

	var chargeContactType: Int = 1

	var hasRangeExtender: Bool = false

	var wallMountability: Int = 0

    var type: Int = 0

    // MARK: - Color Bindings
    
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
    
    // MARK: - Initialization

	init() {
		self.mainColorRed = 0
        self.mainColorGreen = 0
        self.mainColorBlue = 0
        self.secondaryColorRed = 0
        self.secondaryColorGreen = 0
        self.secondaryColorBlue = 0
	}
    
    // MARK: - Set Secondary Color to Main
    
    func setSecondaryColorToMain() {
        let components = mainColorBinding.wrappedValue.components
        secondaryColorRed = components.red
        secondaryColorGreen = components.green
        secondaryColorBlue = components.blue
    }

    func duplicate() -> CordlessHandsetCharger {
        // 1. Initialize a new CordlessHandset, passing the original's properties to the initializer.
        let newCharger = CordlessHandsetCharger()
        newCharger.phone = phone
        newCharger.mainColorRed = mainColorRed
        newCharger.mainColorGreen = mainColorGreen
        newCharger.mainColorBlue = mainColorBlue
        newCharger.secondaryColorRed = secondaryColorRed
        newCharger.secondaryColorGreen = secondaryColorGreen
        newCharger.secondaryColorBlue = secondaryColorBlue
        newCharger.hasRangeExtender = hasRangeExtender
        newCharger.wallMountability = wallMountability
        newCharger.chargeContactType = chargeContactType
        newCharger.chargeContactPlacement = chargeContactPlacement
        newCharger.chargingDirection = chargingDirection
        return newCharger
    }

}
