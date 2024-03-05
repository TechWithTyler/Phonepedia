//
//  Charger.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 6/28/23.
//  Copyright © 2023-2024 SheftApps. All rights reserved.
//

import SwiftUI
import SwiftData

@Model
final class Charger {
    
    // MARK: - Properties

	var phone: Phone?
    
    var id = UUID()

    var mainColorHex: String = Color.black.hex!
    
    var secondaryColorHex: String = Color.black.hex!

	var chargingDirection: Int = 0

	var chargeContactPlacement: Int = 0

	var chargeContactType: Int = 1

	var hasRangeExtender: Bool = false

	var wallMountability: Int = 0
    
    // MARK: - Color Bindings
    
    var mainColorBinding: Binding<Color> {
        Binding<Color> { [self] in
            Color(hexString: mainColorHex)!
        } set: { [self] newColor in
            mainColorHex = newColor.hex!
        }
    }
    
    var secondaryColorBinding: Binding<Color> {
        Binding<Color> { [self] in
            Color(hexString: secondaryColorHex)!
        } set: { [self] newColor in
            secondaryColorHex = newColor.hex!
        }
    }
    
    // MARK: - Initialization

	init() {
        self.mainColorHex = Color.black.hex!
        self.secondaryColorHex = Color.black.hex!
	}
    
    // MARK: - Set Secondary Color to Main
    
    func setSecondaryColorToMain() {
        secondaryColorHex = mainColorHex
    }

}
