//
//  AnsweringSystemGreetingComponents.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 7/4/24.
//  Copyright © 2023-2024 SheftApps. All rights reserved.
//

import Foundation

struct AnsweringSystemGreetingComponents {

    // This method returns either "leave" or "record" for use in the example answering system "record message" greeting.
    static func leaveOrRecord() -> String {
        return ["leave", "record"].randomElement()!
    }

    // This method returns either "a" or "your" for use in the example answering system "record message" greeting.
    static func aOrYour() -> String {
        return ["a", "your"].randomElement()!
    }

    // This method returns either "beep" or "tone" for use in example answering system greetings/call block pre-screening greetings.
    static func beepOrTone() -> String {
        return ["beep", "tone"].randomElement()!
    }

}
