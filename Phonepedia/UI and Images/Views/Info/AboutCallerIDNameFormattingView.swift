//
//  AboutCallerIDNameFormattingView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 4/4/25.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI

struct AboutCallerIDNameFormattingView: View {

    // MARK: - Properties - Dismiss Action

    @Environment(\.dismiss) var dismiss

    // MARK: - Properties - Dialog Manager

    @EnvironmentObject var dialogManager: DialogManager

    // MARK: - Body

    var body: some View {
        let exampleName = NameNumberExamples.callerIDNames.randomElement()!
        let exampleFullNumber = NameNumberExamples.examplePhoneNumber()
        let exampleAreaCode = exampleFullNumber.areaCode
        let exampleCentralExchange = exampleFullNumber.centralExchange
        let exampleLocalNumber = exampleFullNumber.number
        NavigationStack {
            List {
                DisclosureGroup {
                    Text("If the incoming caller ID phone number matches an entry in the phonebook, the entry name is displayed instead of the caller ID name sent by the phone service provider. For example, if the incoming caller ID name is \"\(NameNumberExamples.cnamForName(exampleName))\" and the number is \(NameNumberExamples.formatPhoneNumber(areaCode: exampleAreaCode, centralExchange: exampleCentralExchange, localNumber: exampleLocalNumber, withFormat: .dashed)), and you store that number to the phonebook with name \"\(exampleName)\", the incoming caller ID will show as \"\(exampleName)\" instead of \"\(NameNumberExamples.cnamForName(exampleName))\". On some phones, the number will be displayed in the same format as the phonebook entry, even if the format of the caller ID number itself is different. For example, a 10-digit number will be displayed as 1 + 10-digits if that's how it's stored in the phonebook.")
                } label: {
                    Text("Phonebook Entry Name (Phonebook Match)")
                }
                DisclosureGroup {
                    Text("A caller's name shown in caller ID is called CNAM (Caller NAMe), and is displayed in \"LAST, FIRST\" format so the recipient's phone service provider's systems can sort through the database of names and find the name corresponding to the number. The use of all-caps is to avoid having names like \"McDonald\" appear with only the first letter capitalized (\"Mcdonald\"), and to make it readable on caller ID displays that don't support or properly display lowercase letters (e.g. a low-end cordless phone with a segmented monochrome display). Displaying the name in \"First Last\" format is often one of the reasons people will store names and numbers in the phonebook, even if they don't often use the phonebook for dialing.")
                    Text("If only a location is provided as the CNAM (e.g. San Jose, CA), the name will be displayed as \"SAN JOSE    CA\" instead of \"San Jose, CA\". Having 2 or more spaces between the name and location is due to CNAM being a fixed-width field. CNAM is limited to 15 characters, so in some cases, the name may be truncated in unexpected ways.")
                } label: {
                    Text("CNAM")
                }
                DisclosureGroup {
                    Text("If a name isn't available for a caller, or if you don't have CNAM caller ID with your phone service provider, the number will be displayed as the name in the format \(NameNumberExamples.formatPhoneNumber(areaCode: exampleAreaCode, centralExchange: exampleCentralExchange, localNumber: exampleLocalNumber, withFormat: .plain)) instead of \(NameNumberExamples.formatPhoneNumber(areaCode: exampleAreaCode, centralExchange: exampleCentralExchange, localNumber: exampleLocalNumber, withFormat: .dashed)) or \(NameNumberExamples.formatPhoneNumber(areaCode: exampleAreaCode, centralExchange: exampleCentralExchange, localNumber: exampleLocalNumber, withFormat: .parentheses)), for compatibility with displays that don't support punctuation or that can't fit the full number in punctuated/dashed format.")
                } label: {
                    Text("Number-As-Name")
                }
                DisclosureGroup {
                    Text("STIR/SHAKEN (Secure Telephone Identity Revisited/Signature-based Handling of Asserted Information Using toKENs) is a system used by phone service providers to verify that the caller ID name and number are valid and not spoofed. The originating provider digitally signs the caller ID information, and the destination provider digitally verifies the signature. If a call is verified, the CNAM or number-as-name caller ID is prepended with \"[V]\". If the call is not verified, it's prepended with \"Spam?\", with the \"?\" meaning \"maybe spam, maybe not\". The prepended text uses up part of the caller ID name, so not all names that once fit pre-STIR/SHAKEN will fit, especially on phones/caller ID equipment which assume a 15-character limit. Also note that at the time of the release of this version of \(appName!), STIR/SHAKEN is only used if both ends of the call are VoIP (or VoIP-based cellular networks).")
                } label: {
                    Text("STIR/SHAKEN")
                }
            }
                .navigationTitle("About Caller ID Name Formatting")
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button {
                            dismiss()
                        } label: {
                            Text("Done")
                        }
                    }
                }
            }
#if os(macOS)
            .frame(minWidth: 550, maxWidth: 550, minHeight: 350, maxHeight: 350)
#endif
        }
}

#Preview {
    AboutCallerIDNameFormattingView()
}
