//
//  BaseSpeedDialView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct BaseSpeedDialView: View {

    @Bindable var phone: Phone

    var baseSpeedDialRange: ClosedRange<Int> {
        if phone.voicemailQuickDial == 2 {
            return 0...9
        } else if phone.baseDisplayType == 0 {
            return 0...10
        } else {
            return 0...50
        }
    }

    var body: some View {
        Stepper(phone.isCordless ? "Dial-Key Speed Dial Locations (Base): \(phone.baseSpeedDialCapacity)" : "Dial-Key Speed Dial Locations: \(phone.baseSpeedDialCapacity)", value: $phone.baseSpeedDialCapacity, in: baseSpeedDialRange)
        InfoText("Speed dial is usually used by holding down the desired number key or by pressing a button (usually called \"Auto\", \"Mem\", or \"Memory\") followed by the desired number key.")
        if phone.baseSpeedDialCapacity > 10 {
            InfoText("Speed dial \(phone.baseSpeedDialCapacity > 11 ? "locations 11-\(phone.baseSpeedDialCapacity) are" : "location 11 is") accessed by pressing the speed dial button and then entering/scrolling to the desired location number.")
        }
        Stepper(phone.isCordless ? "One-Touch/Memory Dial Buttons (Base): \(phone.baseOneTouchDialCapacity)" : "One-Touch/Memory Dial Capacity: \(phone.baseOneTouchDialCapacity)", value: $phone.baseOneTouchDialCapacity, in: 0...20)
        InfoText("One-touch/memory dial is when the phone has dedicated speed dial buttons which either start dialing immediately when pressed, or which display/announce the stored number which can be dialed by then going off-hook. Some phones tie the one-touch/memory dial buttons to the first few speed dial locations (e.g. a phone with 10 speed dials (1-9 and 0) and memory dial A-C might use memory dial A-C as a quicker way to dial the number in speed dial 1-3.\nOn many corded phones, each one-touch dial button can hold 2 numbers. The upper number is accessed by simply pressing the one-touch dial button, and the lower number is accessed by pressing a button, often called \"Lower\" followed by the one-touch dial button.")
        if phone.isCordless && phone.baseOneTouchDialCapacity > 0 {
            Toggle("Base One-Touch/Memory Dial Supports Handset Numbers", isOn: $phone.oneTouchDialSupportsHandsetNumbers)
            InfoText("By assigning a handset number to a cordless or corded/cordless phone base's one-touch dial button, you can press it to quickly intercom/transfer a call to that handset, just like how one-touch dial buttons on a business/hotel phone system are often programmed to dial other extension numbers in the business/hotel.")
        }
        if (phone.basePhonebookCapacity > 0 && (phone.baseSpeedDialCapacity > 0 || phone.baseOneTouchDialCapacity > 0)) {
            Picker("Speed Dial Entry Mode", selection: $phone.speedDialPhonebookEntryMode) {
                Text("Manual or Phonebook (Copy)").tag(0)
                Text("Phonebook Only (Copy)").tag(1)
                Text("Phonebook Only (Link)").tag(2)
            }
            SpeedDialEntryModeInfoView()
        }
    }
}

#Preview {
    Form {
        BaseSpeedDialView(phone: Phone(brand: "Panasonic", model: "KX-TG5776"))
    }
    .formStyle(.grouped)
}
