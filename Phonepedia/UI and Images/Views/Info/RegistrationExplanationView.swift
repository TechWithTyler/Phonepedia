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
                Text("For cordless phones that don't exchange a digital security code by placing a handset on the base, the handset must be \"registered\" to the base you want to use it with. Registration is usually performed by pressing and holding a button on the base (usually the handset locator button), by selecting an option in the base menu (if the base has one), by placing an unregistered handset on the base (for select cordless-only models with a charging area on the base), or by entering the base's unique ID into the handset to be registered.")
                Text("For phones that can't accept more than one handset, the registration option is used if you need to replace the handset or base, if it stops communicating for some reason, or if you want to use it on a different base.")
                Text("For phones that can accept 2 or more handsets, the registration/deregistration options are used to change the numbers assigned to each handset (i.e., handset 1, handset 2, and so on) or if they need to be re-registered for any reason (see above).")
                Text("An expandable phone system is one where the base can accept more handsets than it comes with. For example, a cordless phone that only comes with 2 handsets can accept more than 2 if the phone or its packaging/documentation says something like \"expandable\" or \"up to X handsets\" (X represents a maximum number of handsets).")
                Text("The handset number is used when you're prompted to choose a handset for features such as intercom calls, room monitor, and copying phonebook entries, as well as when choosing which handset you want to deregister (for phones where you can choose which handset(s) to deregister). The handset displays this number on the standby display and/or while charging. While it's most common for handset 1 to be the one placed on the base (for cordless-only models with a charging area on the base), you can place any handset on the base.")
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
