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
            return .zeroToMax(9)
        } else if phone.baseDisplayType == 0 {
            return .zeroToMax(10)
        } else {
            return .zeroToMax(50)
        }
    }

    var body: some View {
        Stepper(phone.isCordless ? "Dial-Key Speed Dial Slots (Base): \(phone.baseSpeedDialCapacity)" : "Dial-Key Speed Dial Locations: \(phone.baseSpeedDialCapacity)", value: $phone.baseSpeedDialCapacity, in: baseSpeedDialRange)
        InfoText("Speed dial is usually used by holding down the desired number key or by pressing a button (usually called \"Auto\", \"Mem\", or \"Memory\") followed by the desired number key.")
        if phone.baseSpeedDialCapacity > 10 {
            InfoText("Speed dial \(phone.baseSpeedDialCapacity > 11 ? "slots 11-\(phone.baseSpeedDialCapacity) are" : "slot 11 is") accessed by pressing the speed dial button and then entering/scrolling to the desired location number.")
        }
        Stepper(phone.isCordless ? "One-Touch Dial Buttons (Base): \(phone.baseOneTouchDialCapacity)" : "One-Touch Dial Buttons: \(phone.baseOneTouchDialCapacity)", value: $phone.baseOneTouchDialCapacity, in: .zeroToMax(20))
        InfoText("One-touch dial is used by pressing dedicated speed dial buttons. This either starts dialing immediately, or displays/announces the stored number which can be dialed by then going off-hook. Some phones tie the one-touch buttons to the first few speed dial locations (e.g. a phone with 10 speed dials (1-9 and 0) and one-touch dial A-C might use one-touch dial A-C as a quicker way to dial the number in speed dial 1-3.On many corded phones, each one-touch dial button can hold 2 numbers. The upper number is accessed by simply pressing the one-touch dial button, and the lower number is accessed by pressing a button, often called \"Lower\" followed by the one-touch dial button.")
        if phone.baseOneTouchDialCapacity > 0 {
            Picker("One-Touch Dial Card", selection: $phone.baseOneTouchDialCard) {
                Text("None").tag(0)
                Text("Paper Card/Faceplate").tag(1)
                Text("Display").tag(2)
            }
            Text("Most phones with one-touch dial buttons have a paper card or faceplate where you can write the names/numbers stored to the corresponding buttons.\nMore advanced phones might instead have a display (independent of the main display if any) showing the names/numbers stored to the corresponding buttons.\nIn the case of hotel phones with paper faceplates, the hotel staff fill out worksheets with the desired one-touch dial names (e.g., Front Desk, Concierge, Room Service) and the desired dialing instructions (e.g. to dial 9 + 1 + area code + number for long-distance calls), then send them to the phone manufacturer when placing an order for one or more phones. Depending on the phone, programming is done by the manufacturer, in which case it can't be changed later, or the hotel staff can do it using buttons hidden beneath the faceplate.")
            Toggle("Supports Key Expansion Modules", isOn: $phone.baseOneTouchDialExpansionModulesSupported)
            InfoText("Key expansion modules are cards with additional one-touch dial buttons which attach to a phone.")
            if phone.isCordless {
                Toggle("Base One-Touch/Memory Dial Supports Handset Numbers", isOn: $phone.oneTouchDialSupportsHandsetNumbers)
                InfoText("By assigning a handset number to a cordless or corded/cordless phone base's one-touch dial button, you can press it to quickly intercom/transfer a call to that handset, just like how one-touch dial buttons on a business/hotel phone system are often programmed to dial other extension numbers in the business/hotel.")
            }
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
