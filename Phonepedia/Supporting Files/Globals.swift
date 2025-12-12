//
//  Globals.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 6/23/23.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI

// MARK: - Properties - Strings

// The application name.
let appName: String? = (Bundle.main.infoDictionary?[String(kCFBundleNameKey)] as? String)!

// The sample text to display above the phone description text view and when previewing the current font size in Settings.
let phoneDescriptionSampleText: String = "I bought this phone at a thrift store in June 2023. I've always been wanting this model because of its stylish design."

// The name of the PhoneTypeDefinitionsView section explaining the various cordless phone base types.
let cordlessBaseTypeSectionName: String = "Cordless Phone Base Types"

// The name of the PhoneTypeDefinitionsView section explaining the various corded phone styles.
let cordedPhoneStyleSectionName: String = "Corded Phone Styles"

// The tag of the "All" option in the phone/cordless device filter options.
let allItemsFilterOptionTag: String = "all"

// MARK: - Properties - Integers

// The current year to use as the default value of a phone or cordless device's release year/acquisition year.
let currentYear = Calendar.current.component(.year, from: Date())

// The earliest year of a phone.
let oldestPhoneYear: Int = 1876

// The earliest year of a cordless device.
let oldestHandsetYear: Int = 1980

// The default maximum number of cordless devices.
let defaultMaxCordlessDevices: Int = 5

// The lowest number a phone or cordless device's phonebook capacity must be to support Bluetooth phonebook transfers.
let phonebookTransferRequiredMaxCapacity = 150

// MARK: - Functions

func showHelp() {
    let helpURL = URL(string: "https://techwithtyler20.weebly.com/\((appName?.lowercased())!)help")!
#if os(macOS)
    NSWorkspace.shared.open(helpURL)
#else
    UIApplication.shared.open(helpURL)
#endif
}
