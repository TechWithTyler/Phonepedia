//
//  NameNumberExamples.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 1/10/25.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import Foundation

struct NameNumberExamples {

    // MARK: - Phone Number Format Enum

    // A display format for a NANP (North American Numbering Plan) number.
    enum NANPPhoneNumberFormat {

        case parentheses // Example: (201) 555-1234

        case dashed      // Example: 201-555-1234

        case plain       // Example: 2015551234

    }

    // MARK: - Properties - Arrays

    // Names to use for the answering system greeting/talking caller ID examples
    static var names: [String] = [
        // Answering system greeting examples only
        "TechWithTyler",
        // Answering system greeting and caller ID name examples
        "John Smith",
        "Pat Fleet",
        "Allison Smith",
        "John Doe",
        "Charlie Johnson"
    ]

    // The example names filtered to only include those with two components (first and last name).
    static var callerIDNames: [String] {
        return names.filter { $0.components(separatedBy: .whitespaces).count == 2 }
    }

    // MARK: - Properties - Strings

    static let exampleUKNumber = "2079460018"

    // MARK: - CNAM for Name

    // Takes the given name and converts it from "First Last" to "LAST, FIRST".
    static func cnamForName(_ name: String) -> String {
        // 1. Split name into separate components. There should be 2 of them.
        let splitName = name.components(separatedBy: .whitespaces)
        // 2. Get the first and last names and convert them to uppercase.
        let firstName = splitName.first?.uppercased()
        let lastName = splitName.last?.uppercased()
        // 3. Create a new String with the format "LAST, FIRST".
        let lastFirstName = "\(lastName!), \(firstName!)"
        // 4. Return the new String.
        return lastFirstName
    }

    // MARK: - Random Phone Number (NANP)

    // Returns an example area code, central exchange (middle 3 digits), and local phone number (last 4 digits).
    static func examplePhoneNumber() -> (areaCode: String, centralExchange: String.SubSequence, number: String.SubSequence) {
        // 1. Create an array of example phone numbers.
        let exampleNumbers = [
            "5551234",  // Commonly seen format without area code
            "8675309",  // Famous example from the song "867-5309/Jenny"
            "5550001",  // Generic placeholder
            "5556789",  // Generic placeholder
            "5551122",  // Generic placeholder
            "5678901",  // Generic placeholder
            "4567890"   // Generic placeholder
        ]
        // 2. Create an array of area codes commonly used in examples.
        let areaCodes = ["555", "201", "800", "212"] // 555 (Fictional), 201 (New Jersey), 212 (NYC), 800 (Toll-Free)
        // 3. Pick a random area code and phone number.
        let randomAreaCode = areaCodes.randomElement()!
        let randomNumber = exampleNumbers.randomElement()!
        // 4. Return the full example phone number.
        return (areaCode: randomAreaCode, centralExchange: randomNumber.prefix(3), number: randomNumber.suffix(4))
    }

    // MARK: - Format NANP Phone Number

    // Formats the NANP (North American Numbering Plan) phone number into one of 3 patterns: with parentheses, with dashes, or as a plain number string.
    static func formatPhoneNumber(areaCode: String, centralExchange: String.SubSequence, localNumber: String.SubSequence, withFormat format: NANPPhoneNumberFormat) -> String {
        // Format the number based on the requested format.
        switch format {
        case .parentheses:
            return "(\(areaCode)) \(centralExchange)-\(localNumber)"
        case .dashed:
            return "\(areaCode)-\(centralExchange)-\(localNumber)"
        case .plain:
            return "\(areaCode)\(centralExchange)\(localNumber)"
        }
    }

}
