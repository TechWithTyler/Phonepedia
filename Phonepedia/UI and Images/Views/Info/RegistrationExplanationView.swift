//
//  RegistrationExplanationView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 2/22/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI

struct RegistrationExplanationView: View {
    
    // MARK: - Properties - Dismiss Action
    
    @Environment(\.dismiss) var dismiss
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            List {
                Text("A handset can't simply communicate with any base it's near. Handsets must be \"registered\" to a base or exchange a digital security code with a base.")
                DisclosureGroup("Digital Security Code") {
                    Text("On older cordless phones, the handset and base use a digital security code, which makes sure the handset only communicates with a specific base. On early cordless phones, switches on the base and handset (often hidden DIP switches) were used to set the code, while later phones would choose a random code when placing a handset on the base. Unless this code changes each time a handset is placed on the base, you can add as many handsets as you want--the base doesn't know or care how many handsets are being used on it. You can change which base the handset is used on by placing it on a different one or setting the code switches on the base and handsets to the same one.")
                    Text("If the security code is the same on multiple bases, the handset may attempt to connect to more than one base, making it possible to hear other peoples' conversations if they're using cordless phones of the same brand/model/frequency.")
                    Text("For multi-handset systems, the handset numbers are programmed into each handset and can't be changed. This means, for example, if you added a 3rd handset to a 2-handset system, you'll have 1 handset with the number 1 and 2 handsets with the number 2, or 2 handsets with the number 1 and 1 handset with the number 2.")
                    Text("On some multi-handset systems, system-wide settings like dial mode can only be changed on the handset that shows as number 1.")
                    Text("If the base doesn't have a charging area for a handset and there are no switches to set the digital security code, you can't add/replace handsets--you'll have to replace the entire system.")
                }
                DisclosureGroup("Registration") {
                    Text("For cordless phones that don't exchange a digital security code by placing a handset on the base or by setting switches, the handset must be \"registered\" to the base you want to use it with. Some cordless phones allow you to register an unregistered handset by simply placing it on the base, or enter the base's unique ID into the handset, but on others, you have to put the base into registration mode (e.g., by holding the handset locator button for a few seconds), then put the handset into registration mode (e.g., by selecting a registration option in the menu). Both the base and handset know about each other, so there's a limit of how many handsets can be registered to the base.")
                    Text("For phones that can't accept more than one handset, the registration option is used if you need to replace the handset or base, if it stops communicating for some reason, or if you want to use it on a different base.")
                    Text("For phones that can accept 2 or more handsets, the registration/deregistration options are used to change the numbers assigned to each handset (i.e., handset 1, handset 2, and so on) or if they need to be re-registered for any reason (see above).")
                    Text("Deregistering a handset deletes the registration information from the handset and base. On some phones, you can also forget the base(es) the handset's registered to, or forget the handsets that are registered to the base, if the previous base/handset isn't available. Some phones only support deregistration by registering a handset over the registration of an unused handset, then registering the handset back to the desired slot.")
                    Text("An expandable phone system is one where the base can accept more handsets/desksets than it comes with. For example, a cordless phone that only comes with 2 handsets can accept more than 2 if the phone or its packaging/documentation says something like \"expandable\" or \"up to X handsets\" (X represents a maximum number of handsets).")
                    Text("The handset/deskset number is used when you're prompted to choose a handset/deskset for features such as intercom calls, room monitor, and copying phonebook entries (when the phonebook is stored in the base and each handset/deskset separately), as well as when choosing which handset/deskset you want to deregister (for phones where you can choose which handset(s)/deskset(s) to deregister) or register over. The handset/deskset usually displays this number on the standby display, and/or for handsets, while charging. While it's most common for handset 1 to be the one placed on the base (for cordless-only models with a charging area on the base), you can place any handset on the base if they physically fit and the charging contacts can touch.")
                }
            }
            .navigationTitle("Registration/Security Code Explanation")
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
