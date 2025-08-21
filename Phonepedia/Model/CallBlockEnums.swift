//
//  CallBlockEnums.swift
//  Phonepedia
//
//  Created by Assistant on 12/19/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import Foundation

enum BlockedCallersHear: Int, Codable, CaseIterable, Identifiable {
    case silence = 0
    case busyCustom = 1
    case busyTraditional = 2
    case voiceMessage = 3

    var id: Self { self }
    var label: String {
        switch self {
        case .silence: "Silence"
        case .busyCustom: "Busy Tone (Custom)"
        case .busyTraditional: "Busy Tone (Traditional)"
        case .voiceMessage: "Voice Message"
        }
    }
}

enum AutoDeletePolicy: Int, Codable, CaseIterable, Identifiable {
    case never = 0
    case withoutProtection = 1
    case withProtection = 2

    var id: Self { self }
    var label: String {
        switch self {
        case .never: "Never"
        case .withoutProtection: "Without Protection"
        case .withProtection: "With Protection"
        }
    }
}

enum PreScreeningMode: Int, Codable, CaseIterable, Identifiable {
    case notSupported = 0
    case askForName = 1
    case askForCode = 2

    var id: Self { self }
    var label: String {
        switch self {
        case .notSupported: "Not Supported"
        case .askForName: "Ask for Caller Name"
        case .askForCode: "Ask for Code Entry"
        }
    }
}

enum CellCallRejection: Int, Codable, CaseIterable, Identifiable {
    case notSupported = 0
    case button = 1
    case whenBlocking = 2
    case buttonWhenBlocking = 3

    var id: Self { self }
    var label: String {
        switch self {
        case .notSupported: "Not Supported"
        case .button: "Button"
        case .whenBlocking: "When Blocking"
        case .buttonWhenBlocking: "Button/When Blocking"
        }
    }
}
