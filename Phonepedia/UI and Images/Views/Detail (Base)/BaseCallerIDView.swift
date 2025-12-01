//
//  BaseCallerIDView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI
import SheftAppsStylishUI

struct BaseCallerIDView: View {

    // MARK: - Properties - Objects

    @EnvironmentObject var dialogManager: DialogManager

    @Bindable var phone: Phone

    // MARK: - Body

    var body: some View {
        let exampleName = NameNumberExamples.callerIDNames.randomElement()!
        let exampleFullNumber = NameNumberExamples.examplePhoneNumber()
        let exampleAreaCode = exampleFullNumber.areaCode
        let exampleCentralExchange = exampleFullNumber.centralExchange
        let exampleLocalNumber = exampleFullNumber.number
        InfoText("""
        Caller ID shows the name and/or number of a caller. Depending on your provider, you may need to subscribe to use this service.
        If caller information isn't available for a call, one of the following may be displayed:
        • Private: The caller has intentionally blocked their number using a blocking feature, such as by dialing *67 before the number. In some cases, it may appear as Restricted instead of Private.
        • Out of area: The call is coming from a region or service that doesn't send Caller ID information to your provider, so your phone can't display the name or number.
        • Long distance: Your provider has identified the call as originating from outside your local calling area. Caller ID may still display the number or name if available.
        • Anonymous/Unavailable/Unknown: Caller ID information isn't available for this call. Sometimes, data isn't transmitted at all in this case. This is not to be confused with Private, which is when caller ID information is available but blocked.
        • Wireless: Your provider has identified the call as originating from a cell phone/network and the name and/or number aren't available.
        • Toll-Free: The call is coming from a toll-free number (area code 800, 833, 844, 855, 866, 877, or 888), and a name isn't available.
        """)
        if phone.basePhonebookCapacity > 0 {
            Toggle(isOn: $phone.callerIDPhonebookMatch) {
                Text("Caller ID Name Uses Matching Phonebook Entry Name")
            }
            InfoButton("About Caller ID Name Formatting…") {
                dialogManager.showingAboutCallerIDNameFormatting = true
            }
        }
        if phone.isCordless || phone.cordedPhoneType == 0 {
            Toggle(isOn: $phone.hasTalkingCallerID) {
                Text("Talking Caller ID")
            }
            InfoText("The phone can announce who's calling after each ring, so you don't have to look at the screen. Example: \"Call from \(exampleName)\" for a caller stored in the phonebook, \"Call from \(NameNumberExamples.cnamForName(exampleName))\" for a caller not stored in the phonebook, or \"Call from \(NameNumberExamples.formatPhoneNumber(areaCode: exampleAreaCode, centralExchange: exampleCentralExchange, localNumber: exampleLocalNumber, withFormat: .plain))\" when the caller's number is displayed instead of a name.")
            if phone.hasTalkingCallerID {
                if phone.callerIDPhonebookMatch {
                    ExampleAudioView(audioFile: .talkingCallerIDPhonebook)
                }
                ExampleAudioView(audioFile: .talkingCallerIDCNAM)
                ExampleAudioView(audioFile: .talkingCallerIDNumber)
            }
        }
        if phone.isCordless || phone.baseDisplayType > 2 {
            FormNumericTextField(phone.isCordless ? "Caller ID List Capacity (Base)" : "Caller ID List Capacity", value: $phone.baseCallerIDCapacity, valueRange: .allPositivesIncludingZero, singularSuffix: "entry", pluralSuffix: "entries")
#if !os(visionOS)
                .scrollDismissesKeyboard(.interactively)
#endif
        }
        if phone.hasAnalogLineConnection && phone.hasClock {
            Toggle("Caller ID Time Adjustment", isOn: $phone.callerIDTimeAdjust)
            InfoText("Caller ID data may include not only the name and/or phone number, but also the date and time of the call. This data can be used to automatically set the phone's clock.\nCaller ID data doesn't include the year or day of the week. You may need to manually set the year after a power outage. For this reason, if the year isn't correct and there's a leap day, the date might be incorrect. For phones that store a day of the week, it either has a manually-set year which tells it which day of the week to use, or you need to manually set the day of the week.")
        }
        Toggle("Has Flash Button/Supports Call Waiting", isOn: $phone.supportsCallWaiting)
        InfoText("Call waiting allows you to receive calls even when you are on the phone. Call waiting calls are answered by pressing the flash button or switch hook, and you can do the same to switch between 2 calls, start a new call (\"get a 2nd dial tone\"), or conference 2 calls to create a 3-way call. On analog phones, the phone goes on-hook for a split-second, then back off-hook, to signal to the provider device or central office that you wanted to do any of those actions. The term \"flash\" comes from the switchboard days where each line jack on the switchboard had a light next to it, and this brief \"on-and-off-hook\" would cause this light to flash.\nFlash can be used to put calls on hold at the provider level, and is different from the hold function on the phone itself if it has one, where the phone remains off-hook but the microphone and earpiece/speaker are muted.\nCall Waiting Caller ID (CWID) allows you to receive caller ID for the 2nd call. On analog phones, a high-pitched tone (2130Hz + 2750Hz), called the Customer Premises Equipment Alert Signal tone, will be played after the call waiting tone. This tone tells the phone to play a DTMF \"A\" or \"D\" tone (depending on the caller ID standards the phone supports), if it supports caller ID and is off-hook, to let the provider know it can send caller ID data for the call. Once the phone detects the Customer Premises Equipment Alert Signal tone, incoming audio is briefly muted to prevent the caller ID data tones from being heard and making you wonder \"What was that weird sound I just heard?\".")
        ExampleAudioView(audioFile: .callWaitingTone)
        ExampleAudioView(audioFile: .dtmfToneD)
        ExampleAudioView(audioFile: .dtmfToneA)
    }

}

// MARK: - Preview

#Preview {
    Form {
        BaseCallerIDView(phone: Phone(brand: "AT&T", model: "E5960"))
    }
    .formStyle(.grouped)
}
