//
//  AboutDialingCodesView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 2/5/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI

struct AboutDialingCodesView: View {
    
    // MARK: - Properties - Dismiss Action
    
    @Environment(\.dismiss) var dismiss
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            Text("Before a phone number often comes one or more digits: an international exit code and country code, or a trunk prefix code. Expand the following sections to learn about each code and how to use them.")
                .padding()
            List {
                DisclosureGroup {
                    Text("The international exit code (e.g., 011 for the US) is the code you must prefix to international numbers (i.e., any number with a different country code than yours).")
                } label: {
                    Text("International Exit Code")
                }
                DisclosureGroup {
                    Text("The country code (e.g. 1 for the US) indicates the country where the number you want to call resides. Dial this code after the international exit code.")
                } label: {
                    Text("Country Code")
                }
                DisclosureGroup {
                    let examplePhoneNumber = NameNumberExamples.formatPhoneNumber(areaCode: "925", centralExchange: "555", localNumber: "9876", withFormat: .parentheses)
                    Text("The trunk prefix code (e.g., 1 for the US) is the digit(s) you may be required to dial before the area code when calling a number in your country. For example, in the US, you may be required to dial \(examplePhoneNumber) as 1 \(examplePhoneNumber).")
                } label: {
                    Text("Trunk Prefix Code")
                }
                DisclosureGroup {
                    Text("If you're using a phone on a PBX (private branch exchange) system, you may need to dial one or more digits (e.g., 9) to tell it that you want to make a normal outside call, rather than an internal call to another one of its extensions. This is called the PBX line access number. Depending on how quickly the outside line is activated upon entering the code, when storing the line access number + outside phone number as a full dial string (e.g. for a phonebook or speed dial entry), you may need to add one or more pauses between the code and outside number. Pauses tell the phone to wait for a few seconds before dialing the next digit, and is not interpreted in any way by the line. The length of a single pause digit varies by phone, so you may have to use different numbers of pauses on different phones.")
                    Text("In hotels, the extension number of a room is either the same as the room number, or one or more digits and the room number. For example, if you want to call room 925, you would dial one or more digits followed by 925, or you would simply dial 925, depending on the hotel's PBX system. Instructions in the room or on the phone's faceplate tell guests how to make room-to-room calls and, depending on the PBX, that they have to dial 9 before an outside phone number to make an outside call.")
                    Text("Many PBXs allow you to dial the emergency number (e.g., 911 in the US or 999/112 in the UK) directly, without first dialing the line access number. Upon dialing the emergency number, the PBX would activate the outside line and \"repeat\" the dialed number's DTMF tones or pulses to it, so you may hear the number dialed again after you dial it (for PBXs where the outside line is analog). In some countries, such as the US, the ability to dial the emergency number without first dialing the line access number is a legal requirement for new systems.")
                    Text("If you want to reach a specific PBX extension when calling in from an outside phone, call the main number of the outside line the PBX is connected to. Depending on the system's configuration, you'll be connected to an automated system or a person to help direct your call to the desired extension. You can use a PBX's automated system as a call block pre-screening system, as robots won't be able to enter the desired extension.")
                } label: {
                    Text("Dialing With a PBX")
                }
                DisclosureGroup {
                    Text("Dial the trunk prefix, then the area code and phone number. Depending on your area, local calls must be dialed without the trunk prefix (and sometimes area code) and long-distance calls must be dialed with the trunk prefix.")
                } label: {
                    Text("For Domestic Calls")
                }
                DisclosureGroup {
                    Text("Dial the international exit code, then the country code, then the area/city code and number.")
                } label: {
                    Text("For International Calls")
                }
                DisclosureGroup {
                    let exampleAreaCode: String = "201"
                    let exampleCentralExchange: String.SubSequence = "555"
                    let exampleLocalNumber: String.SubSequence = "1234"
                    let examplePhoneNumber = NameNumberExamples.formatPhoneNumber(areaCode: exampleAreaCode, centralExchange: exampleCentralExchange, localNumber: exampleLocalNumber, withFormat: .parentheses)
                    let examplePhoneNumberDashed = NameNumberExamples.formatPhoneNumber(areaCode: exampleAreaCode, centralExchange: exampleCentralExchange, localNumber: exampleLocalNumber, withFormat: .dashed)
                    Text("""
When you store your international exit code, country code, and trunk prefix codes in the phone, the following conversions will happen when transferring contacts from your cell phone.
• The international dialing symbol (+) will be replaced with the international exit code (e.g., 011 in the US or 00 in the UK).
• If you add the international prefix and your country code to domestic phone numbers (i.e., phone numbers in the same country your phone number is in) in your contacts, and it matches the country code stored in the phone, the transferred entries will have the international prefix and country code (e.g., +1 for US numbers or +44 for UK numbers) replaced with the trunk prefix code (e.g., 1 for US numbers or 0 for UK numbers).
Example scenario: You live in the US and store the international code 011, country code 1, and trunk prefix code 1 into the phone so your contacts will be transferred to the phonebook as follows.
• One of your friends lives in your country, the US, and their number is stored as +1 \(examplePhoneNumber). This number has your country code, so it will be stored as 1-\(examplePhoneNumberDashed) in the phonebook.
• Another one of your friends lives in a different country, the UK, and their number is stored as +44 (20) 4567-8901. This number has a different country code than yours since it's in a different country, so it will be stored as 011442045678901 in the phonebook. Note that international numbers may appear without punctuation.
""")
                } label: {
                    Text("For Cell Phone Phonebook Transfers")
                }
            }
            .navigationTitle("About Dialing Codes")
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
    AboutDialingCodesView()
}
