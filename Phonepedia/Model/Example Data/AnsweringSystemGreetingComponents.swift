//
//  AnsweringSystemGreetingComponents.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 7/4/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

// MARK: - Imports

import Foundation

struct AnsweringSystemGreetingComponents {

    // MARK: - Answering System Greeting Components

    // This method returns either "leave" or "record" for use in the example answering system "record message" greeting.
    static func leaveOrRecord() -> String {
        let words = ["leave", "record"]
        return words.randomElement()!
    }

    // This method returns either "a" or "your" for use in the example answering system "record message" greeting.
    static func aOrYour() -> String {
        let words = ["a", "your"]
        return words.randomElement()!
    }

    // This method returns either "beep" or "tone" for use in example answering system greetings/call block pre-screening greetings.
    static func beepOrTone() -> String {
        let words = ["beep", "tone"]
        return words.randomElement()!
    }

    // This method returns either "again" or "back" for use in the example answering system "answer only" greeting.
    static func againOrBack() -> String {
        let words = ["back", "again"]
        return words.randomElement()!
    }

}
