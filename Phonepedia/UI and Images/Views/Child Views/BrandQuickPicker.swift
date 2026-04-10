//
//  BrandQuickPicker.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 3/23/26.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI

struct BrandQuickPicker: View {

    // MARK: - Properties - Strings

    @Binding var brandText: String

    // Brands of phones that were never put on cordless phones.
    var nonCordlessBrands: [String] {
        // 1. Create an array of brands that were never put on cordless phones.
        var brands: [String] = [
            "Western Electric",
            "Lucent",
            "Crosley",
            "Scitec",
            "ITT",
            "Stromberg-Carlson",
            "Kellogg",
            "Automatic Electric",
            "Northern Electric",
            "WECO"
        ]
        // 2. Add the cordless phone brands to the list.
        brands.append(contentsOf: cordlessBrands)
        // 3. Sort the brands in ascending order.
        let sortedBrands = brands.sorted(by: <)
        // 4. Return the sorted brands.
        return sortedBrands
    }

    // Brands of phones that were put on any phone.
    var cordlessBrands: [String] {
        // 1. Create a list of brands.
        let brands: [String] = [
            "Panasonic",
            "Uniden",
            "Vtech",
            "AT&T",
            "Sony",
            "SBC",
            "GTE",
            "Avaya",
            "Motorola",
            "Gigaset",
            "General Electric",
            "Southwestern Bell",
            "Northwestern Bell",
            "BellSouth",
            "Bell",
            "Toshiba",
            "Sanyo",
            "Qwest",
            "Sprint",
            "Verizon",
            "BT",
            "Binatone",
            "Telefunken",
            "Deutsche Telekom",
            "T-Home",
            "T-Com",
            "Siemens",
            "Emerson",
            "Bang & Olufsen",
            "SwissVoice",
            "Alcatel",
            "Telstra",
            "RadioShack",
            "Presidian",
            "Spark",
            "Telecom",
            "Cortelco",
            "Cisco",
            "Grandstream",
            "Yealink",
            "Nortel",
            "Polycom",
            "Poly",
            "Teledex",
            "TeleMatrix",
            "Bittel",
            "AEI",
            "Philips",
            "RCA",
            "Clarity",
            "Doro",
            "Geemarc",
            "IDECT",
            "Brondi",
            "Beetel",
            "TalkTalk",
            "Oricom",
            "Amplicomms",
            "Topo",
            "Logicom",
            "SPC Telecom",
            "Denver Electronics",
            "FRITZ!Fon",
            "AVM",
            "Telekom Speedphone",
            "Swisscom",
            "Orange",
            "SFR",
            "Snom",
            "Spectralink",
            "RTX",
            "Ascom",
            "Mitel",
            "NEC",
            "Vertical Communications",
            "Fanvil",
            "Htek",
            "Akuvox",
            "Flyingvoice",
            "Escene",
            "Ubiquiti (UniFi Talk)",
            "ZYCOO",
            "DBTel",
            "Voxtech",
            "Hartmann & Braun",
            "Pioneer",
            "Sharp",
            "Funai",
            "Maxell",
            "Telrad",
            "Tiptel",
            "Aastra",
            "Ericsson",
            "Plantronics"
        ]
        // 2. Sort the brands in ascending order.
        let sortedBrands = brands.sorted(by: <)
        // 3. Return the sorted brands.
        return sortedBrands
    }

    // MARK: - Properties - Booleans

    var cordless: Bool

    // MARK: - Body

    var body: some View {
        Menu("Quick Pick") {
            ForEach(cordless ? cordlessBrands : nonCordlessBrands, id: \.self) { brand in
                Button(brand) {
                    brandText = brand
                }
            }
        }
    }

}

// MARK: - Preview

#Preview("Cordless") {
    BrandQuickPicker(brandText: .constant("Panasonic"), cordless: true)
}

#Preview("Not Cordless") {
    BrandQuickPicker(brandText: .constant("Western Electric"), cordless: false)
}
