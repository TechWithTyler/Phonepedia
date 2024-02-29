//
//  AboutDialingCodesView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 2/5/24.
//  Copyright © 2024 SheftApps. All rights reserved.
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
                    Text("The international exit code (e.g., 011 for the US) is the code you must prefix to internaional numbers (i.e., any number with a different country code than yours).")
                } label: {
                    Text("International Exit Code")
                }
                DisclosureGroup {
                    Text("The country code (e.g. 1 for the US) indicates the country where the number you want to call resides. Dial this code after the international exit code.")
                } label: {
                    Text("Country Code")
                }
                DisclosureGroup {
                    Text("The trunk prefix code (e.g., 1 for the US) is the digit(s) you may be required to dial when calling a number in your country. For example, in the US, you may be required to dial (925) 555-9876 as 1 (925) 555-9876.")
                } label: {
                    Text("Trunk Prefix Code")
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
                    Text("""
When you store your international exit code, country code, and trunk prefix codes in the phone, the following conversions will happen when transferring contacts from your cell phone.
• The international prefix (+) will be replaced with the international exit code (e.g., 011 in the US or 00 in the UK).
• If you add the international prefix and your country code to domestic phone numbers (i.e., phone numbers in the same country your phone number is in) in your contacts, and it matches the country code stored in the phone, the transferred entries will have the international prefix and country code (e.g., +1 for US numbers or +44 for UK numbers) replaced with the trunk prefix code (e.g., 1 for US numbers or 0 for UK numbers).
Example scenario: You live in the US and store the international code 011, country code 1, and trunk prefix code 1 into the phone so your contacts will be transferred to the phonebook as follows.
• One of your friends lives in your coutry, the US, and their number is stored as +1 (555) 555-1234. This number has your country code, so it will be stored as 1-555-555-1234 in the phonebook.
• Another one of your friends lives in a different country, the UK, and their number is stored as +44 (20) 4567-8901. This number has a different country code than yours since it's in a different country, so it will be stored as 011442045678901 in the phonebook.
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
