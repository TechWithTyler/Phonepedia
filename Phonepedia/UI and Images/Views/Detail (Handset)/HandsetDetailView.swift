//
//  HandsetDetailView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 6/19/23.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct HandsetDetailView: View {

    // MARK: - Properties - Handset

    @Bindable var handset: CordlessHandset

    // MARK: - Properties - Dialog Manager

    @EnvironmentObject var dialogManager: DialogManager

    // MARK: - Body

    var body: some View {
        Form {
            Section {
                HandsetActionsView(handset: handset)
            }
            Section("Basics") {
                FormTextField("Brand", text: $handset.brand)
                FormTextField("Model", text: $handset.model)
                FormNavigationLink {
                    HandsetGeneralView(handset: handset)
                        .navigationTitle("General (HS\(handset.handsetNumber + 1))")
#if !os(macOS)
                        .navigationBarTitleDisplayMode(.inline)
#endif
                } label: {
                    Label("General", systemImage: "gearshape")
                }
                if handset.cordlessDeviceType < 2 {
                if handset.handsetStyle < 3 {
                    FormNavigationLink {
                        HandsetDisplayBacklightButtonsView(handset: handset)
                            .navigationTitle("Disp/B.light/Buttons (HS\(handset.handsetNumber + 1))")
#if !os(macOS)
                            .navigationBarTitleDisplayMode(.inline)
#endif
                    } label: {
                        Label("Display/Backlight/Buttons", systemImage: "5.square")
                    }
                }
                FormNavigationLink {
                    HandsetMessagingView(handset: handset)
                        .navigationTitle("Msg-ing (HS\(handset.handsetNumber + 1))")
#if !os(macOS)
                        .navigationBarTitleDisplayMode(.inline)
#endif
                } label: {
                    Label("Messaging", systemImage: "recordingtape")
                }
            }
                Section("Audio") {
                    FormNavigationLink {
                        HandsetRingersView(handset: handset)
                            .navigationTitle("Ringers (HS\(handset.handsetNumber + 1))")
#if !os(macOS)
                            .navigationBarTitleDisplayMode(.inline)
#endif
                    } label: {
                        Label("Ringers", systemImage: "bell")
                    }
                    FormNavigationLink {
                        HandsetAudioView(handset: handset)
                            .navigationTitle("Spkr/Headset (HS\(handset.handsetNumber + 1))")
#if !os(macOS)
                            .navigationBarTitleDisplayMode(.inline)
#endif
                    } label: {
                        Label("Speakerphone/Headset", systemImage: "speaker")
                    }
                }
                Section("Entries") {
                    FormNavigationLink {
                        HandsetRedialView(handset: handset)
                            .navigationTitle("Redial (HS\(handset.handsetNumber + 1))")
#if !os(macOS)
                            .navigationBarTitleDisplayMode(.inline)
#endif
                    } label: {
                        Label("Redial", systemImage: "phone.arrow.up.right")
                    }
                    FormNavigationLink {
                        HandsetPhonebookView(handset: handset)
                            .navigationTitle("P.book (HS\(handset.handsetNumber + 1))")
#if !os(macOS)
                            .navigationBarTitleDisplayMode(.inline)
#endif
                    } label: {
                        Label("Phonebook", systemImage: "book")
                    }
                    FormNavigationLink {
                        HandsetCallerIDView(handset: handset)
                            .navigationTitle("CID (HS\(handset.handsetNumber + 1))")
#if !os(macOS)
                            .navigationBarTitleDisplayMode(.inline)
#endif
                    } label: {
                        Label("Caller ID", systemImage: "phone.bubble.left")
                    }
                    FormNavigationLink {
                        HandsetSpeedDialView(handset: handset)
                            .navigationTitle("Quick Dial (HS\(handset.handsetNumber + 1))")
#if !os(macOS)
                            .navigationBarTitleDisplayMode(.inline)
#endif
                    } label: {
                        Label("Quick Dialing", systemImage: "person.3")
                    }
                }
                Section {
                    FormNavigationLink {
                        HandsetSpecialFeaturesView(handset: handset)
                            .navigationTitle("Special (HS\(handset.handsetNumber + 1))")
#if !os(macOS)
                            .navigationBarTitleDisplayMode(.inline)
#endif
                    } label: {
                        Label("Special Features", systemImage: "sparkle")
                    }
                }
            }
        }
        .formStyle(.grouped)
    }

}

#Preview {
    @Previewable @State var handset = CordlessHandset(brand: "Panasonic", model: "KX-TGFA97", mainColorRed: 120, mainColorGreen: 120, mainColorBlue: 120, secondaryColorRed: 0, secondaryColorGreen: 0, secondaryColorBlue: 0, accentColorRed: 0, accentColorGreen: 0, accentColorBlue: 0)
    handset.phone = Phone(brand: "Panasonic", model: "KX-TGF975")
    return HandsetDetailView(handset: handset)
        .environmentObject(DialogManager())
}
