//
//  RegistrationExplanationView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 2/22/24.
//  Copyright © 2023-2024 SheftApps. All rights reserved.
//

import SwiftUI

struct RegistrationExplanationView: View {
    
    // MARK: - Properties - Dismiss Action
    
    @Environment(\.dismiss) var dismiss
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            List {
                DisclosureGroup("Digital Security Code") {
                    Text("When placing the handset on the base, the handset and base exchange a digital security code, which makes sure the handset only communicates with that base. Unless this code changes each time a handset is placed on the base, you can add as many handsets as you want--the base doesn't know or care how many handsets are being used on it. You can change which base the handset is used on by placing it on a different one.")
                    Text("On some multi-handset systems, system-wide settings like dial mode can only be changed on handset 1.")
                    Text("If the base doesn't have a charging area for a handset, you can't add/replace handsets--you'll have to replace the entire system.")
                }
                DisclosureGroup("Registration") {
                    Text("For cordless phones that don't exchange a digital security code by placing a handset on the base, the handset must be \"registered\" to the base you want to use it with. Some cordless phones allow you to register an unregistered handset by simply placing it on the base, or enter the base's unique ID into the handset, but on others, you have to put the base into registration mode (e.g., by holding the handset locator button for a few seconds), then put the handset into registration mode (e.g., by selecting a registration option in the menu).")
                    Text("For phones that can't accept more than one handset, the registration option is used if you need to replace the handset or base, if it stops communicating for some reason, or if you want to use it on a different base.")
                    Text("For phones that can accept 2 or more handsets, the registration/deregistration options are used to change the numbers assigned to each handset (i.e., handset 1, handset 2, and so on) or if they need to be re-registered for any reason (see above).")
                    Text("An expandable phone system is one where the base can accept more handsets/desksets than it comes with. For example, a cordless phone that only comes with 2 handsets can accept more than 2 if the phone or its packaging/documentation says something like \"expandable\" or \"up to X handsets\" (X represents a maximum number of handsets).")
                    Text("The handset/deskset number is used when you're prompted to choose a handset/deskset for features such as intercom calls, room monitor, and copying phonebook entries (when the phonebook is stored in the base and each handset/deskset separately), as well as when choosing which handset/deskset you want to deregister (for phones where you can choose which handset(s)/deskset(s) to deregister). The handset/deskset usually displays this number on the standby display, and/or for handsets, while charging. While it's most common for handset 1 to be the one placed on the base (for cordless-only models with a charging area on the base), you can place any handset on the base if they physically fit and the charging contacts can touch.")
                }
            }
            .navigationTitle("Registration Explanation")
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
        .frame(minWidth: 600, maxWidth: 600, minHeight: 400, maxHeight: 400)
#endif
    }
    
}

#Preview {
    RegistrationExplanationView()
}
