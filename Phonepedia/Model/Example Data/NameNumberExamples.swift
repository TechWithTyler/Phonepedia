//
//  NameNumberExamples.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 1/10/25.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import Foundation

struct NameNumberExamples {

    // MARK: - Phone Number Format Enum

    enum PhoneNumberFormat {
        case parentheses // Example: (555) 555-1234
        case dashed      // Example: 555-555-1234
        case plain        // Example: 5555551234
    }

    // MARK: - Properties - Arrays

    // Names to use for the answering system greeting/talking caller ID examples
    static var names: [String] = [
        "TechWithTyler",
        "John Smith",
        "Pat Fleet",
        "Allison Smith",
        "Charlie Johnson"
    ]

    // MARK: - CNAM for Name

    // Takes the given name and converts it from "First Last" to "LAST, FIRST".
    static func cnamForName(_ name: String) -> String {
        // 1. Split name into separate components.
        let splitName = name.components(separatedBy: " ")
        // 2. Get the first and last names and convert them to uppercase.
        let firstName = splitName.first?.uppercased()
        let lastName = splitName.last?.uppercased()
        // 3. Create a new String with the format "LAST, FIRST".
        let lastFirstName = "\(lastName!), \(firstName!)"
        // 4. Return the new String.
        return lastFirstName
    }

    // MARK: - Random Phone Number

    static func examplePhoneNumber() -> (areaCode: String, centralExchange: String.SubSequence, number: String.SubSequence) {
        // 1. Create an array of example phone numbers.
        let exampleNumbers = [
            "5551234",  // Commonly seen format without area code
            "8675309",  // Famous example from the song "867-5309/Jenny"
            "5550001",  // Generic placeholder
            "5556789",  // Generic placeholder
            "5551122",  // Generic placeholder
            "5678901",  // Generic placeholder
            "4567890"
        ]
        // 2. Create an array of area codes commonly used in examples.
        let areaCodes = ["555", "201", "800", "212"] // 201 (New Jersey), 212 (NYC)
        // 3. Pick a random area code and phone number.
        let randomAreaCode = areaCodes.randomElement()!
        let randomNumber = exampleNumbers.randomElement()!
        return (areaCode: randomAreaCode, centralExchange: randomNumber.prefix(3), number: randomNumber.suffix(4))
    }

    static func formatPhoneNumber(areaCode: String, centralExchange: String.SubSequence, localNumber: String.SubSequence, withFormat format: PhoneNumberFormat) -> String {
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
