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
            "Stromberg-Carlson",
            "Kellogg",
            "Automatic Electric",
            "Northern Electric",
            "WECO",
            "Htek",
            "Akuvox",
            "Escene",
            "ZYCOO"
        ]
        // 2. Add the cordless phone brands to the list.
        brands.append(contentsOf: cordlessBrands)
        // 3. Sort the brands in ascending order.
        let sortedBrands = brands.sorted(by: <)
        // 4. Return the sorted brands.
        return sortedBrands
    }

    // Brands of phones that were put on any cordless phone.
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
            "Siemens",
            "Gigaset",
            "Unify",
            "Snom",
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
            "Steren",
            "Intelbras",
            "BT",
            "EE",
            "Binatone",
            "Telefunken",
            "Deutsche Telekom",
            "T-Home",
            "T-Com",
            "Emerson",
            "Bang & Olufsen",
            "Swissvoice",
            "Alcatel",
            "Telstra",
            "RadioShack",
            "Presidian",
            "Telecom",
            "Spark",
            "Cortelco",
            "ITT",
            "Scitec",
            "Brother",
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
            "Logicom",
            "SPC Telecom",
            "Denver Electronics",
            "AVM",
            "FRITZ!",
            "Swisscom",
            "Orange",
            "SFR",
            "Spectralink",
            "RTX",
            "Ascom",
            "Mitel",
            "NEC",
            "Vertical Communications",
            "Ubiquiti",
            "DBTel",
            "Hartmann & Braun",
            "Pioneer",
            "Sharp",
            "Telrad",
            "Tiptel",
            "Aastra",
            "Ericsson",
            "Plantronics",
            "Cisco",
            "Grandstream",
            "Yealink",
            "Fanvil",
            "Flyingvoice"
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
