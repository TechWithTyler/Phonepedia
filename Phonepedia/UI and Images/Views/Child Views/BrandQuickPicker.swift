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
            "Ericsson (legacy PSTN sets)",
            "WECO"
        ]
        brands.append(contentsOf: cordlessBrands)
        let sortedBrands = brands.sorted(by: <)
        return sortedBrands
    }

    // Brands of phones that were put on any phone.
    var cordlessBrands: [String] {
        let brands: [String] = [
            "Panasonic",
            "Sony",
            "Uniden",
            "Vtech",
            "AT&T",
            "SBC",
            "GTE",
            "Avaya",
            "Motorola",
            "Gigaset",
            "General Electric",
            "Southwestern Bell",
            "Northwestern Bell",
            "Bell",
            "BellSouth",
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
        let sortedBrands = brands.sorted(by: <)
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
