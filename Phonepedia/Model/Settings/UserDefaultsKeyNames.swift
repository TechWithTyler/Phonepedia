//
//  UserDefaultsKeyNames.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 12/6/24.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import Foundation

extension UserDefaults {

    struct KeyNames {

        // MARK: - UserDefaults Key Names

        static let useDetailedPhoneImage: String = "useDetailedPhoneImage"

        static let phoneDescriptionTextSize: String = "phoneDescriptionTextSize"

        static let showPhoneTypeInList: String = "showPhoneTypeInList"

        static let showPhoneActiveStatusInList: String = "showPhoneActiveStatusInList"

        static let showAnsweringSystemInList: String = "showAnsweringSystemInList"

        static let showNumberOfCordlessHandsetsInList: String = "showNumberOfCordlessHandsetsInList"

        static let highlightHandsetNumberDigitInList: String = "highlightHandsetNumberDigitInList"

        static let showPhoneColorsInList: String = "showPhoneColorsInList"

        static let defaultAnalogPhoneConnectedToSelection = "defaultAnalogPhoneConnectedToSelection"

        static let defaultAcquisitionMethod = "defaultAcquisitionMethod"

        static let showYearsInList: String = "showYearsInList"

        static let showFrequencyInList: String = "showFrequencyInList"

        static let brandSortMode: String = "brandSortMode"

    }

}
