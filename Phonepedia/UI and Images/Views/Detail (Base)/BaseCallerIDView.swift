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

    @Bindable var phone: Phone

    var body: some View {
        let exampleName = NameNumberExamples.names.randomElement()!
        let exampleFullNumber = NameNumberExamples.examplePhoneNumber()
        let exampleAreaCode = exampleFullNumber.areaCode
        let exampleCentralExchange = exampleFullNumber.centralExchange
        let exampleLocalNumber = exampleFullNumber.number
        if phone.basePhonebookCapacity > 0 {
            Toggle(isOn: $phone.callerIDPhonebookMatch) {
                Text("Caller ID Name Uses Matching Phonebook Entry Name")
            }
            InfoText("If the incoming caller ID phone number matches an entry in the phonebook, the entry name is displayed instead of the caller ID name sent by the phone service provider. For example, if the incoming caller ID name is \"\(NameNumberExamples.cnamForName(exampleName))\" and the number is \(NameNumberExamples.formatPhoneNumber(areaCode: exampleAreaCode, centralExchange: exampleCentralExchange, localNumber: exampleLocalNumber, withFormat: .dashed)), and you store that number to the phonebook with name \"\(exampleName)\", the incoming caller ID will show as \"\(exampleName)\" instead of \"\(NameNumberExamples.cnamForName(exampleName))\".\nA caller's name shown in caller ID is called CNAM, and is displayed in \"LAST, FIRST\" format so the recipient's phone service provider's systems can sort through the database of names and find the name corresponding to the number. The use of all-caps is to avoid having names like \"McDonald\" appear with only the first letter capitalized, and to make it readable on caller ID displays that don't support or properly display lowercase letters (e.g. a low-end cordless phone with a segmented monochrome display). Displaying the name in \"First Last\" format is often one of the reasons people will store names and numbers in the phonebook, even if they don't often use the phonebook for dialing.\nIf a name isn't available for a caller, or if you don't have CNAM caller ID with your phone service provider, the number will be displayed as the name in the format \(NameNumberExamples.formatPhoneNumber(areaCode: exampleAreaCode, centralExchange: exampleCentralExchange, localNumber: exampleLocalNumber, withFormat: .plain)) instead of \(NameNumberExamples.formatPhoneNumber(areaCode: exampleAreaCode, centralExchange: exampleCentralExchange, localNumber: exampleLocalNumber, withFormat: .dashed)) or \(NameNumberExamples.formatPhoneNumber(areaCode: exampleAreaCode, centralExchange: exampleCentralExchange, localNumber: exampleLocalNumber, withFormat: .parentheses)), for compatibility with displays that don't support punctuation.")
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
        InfoText("Call waiting allows you to receive calls even when you are on the phone. Call Waiting Caller ID (CWID) allows you to receive caller ID for the 2nd call. On analog phones, a high-pitched tone, called the Customer Premise Equipment Alert Signal tone, will be played after the call waiting tone. This tone tells the phone to play a DTMF \"D\" tone to let the provider know it can send caller ID data for the call.")
        ExampleAudioView(audioFile: .callWaitingTone)
        ExampleAudioView(audioFile: .dtmfToneD)
    }
}

#Preview {
    Form {
        BaseCallerIDView(phone: Phone(brand: "AT&T", model: "E5960"))
    }
    .formStyle(.grouped)
}
