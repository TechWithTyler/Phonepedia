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
                    Text("On older cordless phones, the handset and base use a digital security code, which makes sure the handset only communicates with a specific base. The security code on the handset must match the one on the desired base. On early cordless phones, switches on the base and handset (often hidden DIP switches) were used to set the code, while later phones would choose a random code when placing a handset on the base. Unless this code changes each time a handset is placed on the base, you can add as many handsets as you want--the base doesn't know or care how many handsets are being used on it. You can change which base the handset is used on by placing it on a different one or setting the code switches on the base and handsets to the same one.")
                    Text("For phones where the security code is set by placing the handset on the base, there's a 1-in-x chance the security code may end up being the same as that of another base, where x represents the number of possible security codes that the phone will select (usually about a million). For phones where the security code is set using switches on the base and handset, the possibility of 2 bases sharing the same code increases.")
                    Text("If the security code is the same on multiple bases, the handset may attempt to connect to more than one base, making it possible to hear other peoples' conversations if they're using cordless phones of the same brand/model/frequency.")
                    Text("For multi-handset systems, the handset numbers are programmed into each handset and can't be changed. This means, for example, if you added a 3rd handset to a 2-handset system, you'll have 1 handset with the number 1 and 2 handsets with the number 2, or 2 handsets with the number 1 and 1 handset with the number 2. These kinds of phones never officially supported more than the number of handsets they came with, so any additional handsets you use with them were once part of another set.")
                    Text("On multi-handset systems where the handset doesn't need to link to the base to show the current setting for system-wide settings like dial mode, these settings can only be changed on the handset that shows as number 1. This design prevents both handsets from being able to show the same options with their current settings potentially differing.")
                    Text("If the base doesn't have a charging area for a handset and there are no switches to set the digital security code, you can't add/replace handsets--you'll have to replace the entire system.")
                }
                DisclosureGroup("Registration") {
                    Text("For digital cordless phones that don't exchange a digital security code by placing a handset on the base or by setting switches, the handset must be \"registered\" to the base you want to use it with. Some cordless phones allow you to register an unregistered handset by simply placing it on the base, or by entering the base's unique ID into the handset, but on others, you have to put the base into registration mode (e.g., by holding the handset locator button for a few seconds), then put the handset into registration mode (e.g., by selecting a registration option in the menu). Both the base and handset know about each other, so there's a limit of how many handsets can be registered to the base.")
                    Text("For phones that can't accept more than one handset, the registration option is used if you need to replace the handset or base, if the handset stops communicating for some reason, or if you want to use it on a different base.")
                    Text("For phones that can accept 2 or more handsets, the registration/deregistration options are used to change the numbers assigned to each handset (i.e., handset 1, handset 2, and so on) or if they need to be re-registered for any reason (see above).")
                    Text("Deregistering a handset deletes the registration information from the handset and base. On some phones, you can also forget the base(s) the handset's registered to, or forget the handsets that are registered to the base, if the previous base/handset isn't available. Some phones only support deregistration by registering a handset over the registration of an unused handset, then registering the handset back to the desired slot.")
                    Text("An expandable phone system is one where the base can accept more handsets/desksets than it comes with. For example, a cordless phone that only comes with 2 handsets can accept more than 2 if the phone or its packaging/documentation says something like \"expandable\" or \"up to X handsets\" (X represents a maximum number of handsets).")
                    Text("The handset/deskset number is used when you're prompted to choose a handset/deskset for features such as intercom calls, room monitor, and copying phonebook entries (when the phonebook is stored in the base and each handset/deskset separately), as well as when choosing which handset/deskset you want to deregister (for phones where you can choose which handset(s)/deskset(s) to deregister) or register over. The handset/deskset usually displays this number on the standby display, and/or for handsets, while charging. While it's most common for handset 1 to be the one placed on the base (for cordless-only models with a charging area on the base), you can place any handset on the base if they physically fit and the charging contacts can touch.")
                }
                DisclosureGroup("Cordless Device Slots") {
                    Text("The base's memory of a registered cordless device is sometimes referred to as a \"slot\".")
                    Text("On some phones, certain handset/deskset settings are stored in the handset/deskset's slot in the base rather than in the handset/deskset itself. This means that if you deregister a handset from that slot and register a different handset in its place, that handset now uses the settings that were set by the other handset if the setting isn't reset upon deregistration. The handset name setting is a common example--the setting is stored in the handset's slot in the base so the name can be displayed in handset lists (e.g. for intercom).")
                    Text("Storing settings in the base's handset slots instead of the handsets themselves allows for the ability to set all handsets/desksets/the base to the same setting at once (e.g. setting the talking caller ID for all handsets/desksets/the base to on or off) even if some of the registered handsets/desksets are out of range. If the base sends a signal to handsets to tell them to change a setting, handsets/desksets that are out of range or that have connection problems won't be affected. Another reason for storing certain handset/deskset settings this way is if the phone behaves differently based on how many handsets/desksets have such settings turned on or off, without the base having to \"check in\" with each handset/deskset. For example, on a call block pre-screening phone with talking caller ID where the caller is asked for their name, the name announcement might be heard upon answering only if all handsets/desksets/the base have their talking caller ID turned off.")
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
