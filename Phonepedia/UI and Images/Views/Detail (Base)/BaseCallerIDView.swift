//
//  BaseCallerIDView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct BaseCallerIDView: View {

    @EnvironmentObject var dialogManager: DialogManager

    @Bindable var phone: Phone

    var body: some View {
        let exampleName = NameNumberExamples.callerIDNames.randomElement()!
        let exampleFullNumber = NameNumberExamples.examplePhoneNumber()
        let exampleAreaCode = exampleFullNumber.areaCode
        let exampleCentralExchange = exampleFullNumber.centralExchange
        let exampleLocalNumber = exampleFullNumber.number
        if phone.basePhonebookCapacity > 0 {
            Toggle(isOn: $phone.callerIDPhonebookMatch) {
                Text("Caller ID Name Uses Matching Phonebook Entry Name")
            }
            InfoButton(title: "About Caller ID Name Formatting…") {
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
        if phone.isCordless || phone.baseDisplayType > 0 {
            FormNumericTextField(phone.isCordless ? "Caller ID List Capacity (Base)" : "Caller ID List Capacity", value: $phone.baseCallerIDCapacity, valueRange: .allPositivesIncludingZero, singularSuffix: "entry", pluralSuffix: "entries")
#if !os(visionOS)
                .scrollDismissesKeyboard(.interactively)
#endif
        }
        Toggle("Supports Call Waiting", isOn: $phone.supportsCallWaiting)
        InfoText("Call waiting allows you to receive calls even when you are on the phone.\nCall Waiting Caller ID (CWID) allows you to receive caller ID for the 2nd call. On analog phones, a high-pitched tone (2130Hz + 2750Hz), called the Customer Premise Equipment Alert Signal tone, will be played after the call waiting tone. This tone tells the phone to play a DTMF \"A\" or \"D\" tone (depending on the caller ID standards the phone supports, if it supports caller ID and is off-hook, to let the provider know it can send caller ID data for the call. Once the phone detects the Customer Premise Equipment Alert Signal tone, incoming audio is briefly muted to prevent the caller ID data tones from being heard and making you wonder \"What was that weird sound I just heard?\".")
        ExampleAudioView(audioFile: .callWaitingTone)
        ExampleAudioView(audioFile: .dtmfToneD)
        ExampleAudioView(audioFile: .dtmfToneA)
    }
}

#Preview {
    Form {
        BaseCallerIDView(phone: Phone(brand: "AT&T", model: "E5960"))
    }
    .formStyle(.grouped)
}
