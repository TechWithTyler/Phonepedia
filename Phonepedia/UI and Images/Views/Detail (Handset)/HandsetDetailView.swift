//
//  HandsetDetailView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 6/19/23.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI
import SheftAppsStylishUI

struct HandsetDetailView: View {

    // MARK: - Properties - Objects

    @Bindable var handset: CordlessHandset

    @EnvironmentObject var dialogManager: DialogManager

    // MARK: - Body

    var body: some View {
        if let phone = handset.phone {
            SlickBackdropView {
                Form {
                    Section {
                        HStack {
                            Spacer()
                            PhoneImage(phone: phone, displayMode: .full)
                            Spacer()
                        }
                    }
                    Section("Cordless Device \(handset.actualHandsetNumber) Actions") {
                        HandsetActionsView(handset: handset)
                    }
                    basicsGroup
                    audioGroup
                    entriesGroup
                    specialsGroup
                }
                .formStyle(.grouped)
            } backdropContent: {
                PhoneImage(phone: phone, displayMode: .backdrop)
            }
            .scrollContentBackground(.hidden)
        }
    }

    // MARK: - Detail Section Groups

    @ViewBuilder
    var basicsGroup: some View {
        if let phone = handset.phone {
            Section("Basics") {
                FormTextField("Brand", text: $handset.brand)
                    .onChange(of: handset.brand) { oldValue, newValue in
                        handset.brandChanged(oldValue: oldValue, newValue: newValue)
                    }
                FormTextField("Model", text: $handset.model)
                FormNavigationLink(phone: phone) {
                    HandsetGeneralView(handset: handset)
                        .navigationTitle("General (HS\(handset.actualHandsetNumber))")
#if !os(macOS)
                        .navigationBarTitleDisplayMode(.inline)
#endif
                } label: {
                    Label("General", systemImage: "gearshape")
                }
                FormNavigationLink(phone: phone) {
                    HandsetPowerView(handset: handset)
                        .navigationTitle("Power (HS\(handset.actualHandsetNumber))")
                } label: {
                    Label("Power/Charging", systemImage: "battery.100percent")
                }
                FormNavigationLink(phone: phone) {
                    HandsetColorView(handset: handset)
                        .navigationTitle("Colors (HS\(handset.actualHandsetNumber))")
                } label: {
                    Label("Colors", systemImage: "paintpalette")
                }
                if handset.cordlessDeviceType < 2 {
                    if handset.handsetStyle < 3 {
                        FormNavigationLink(phone: phone) {
                            HandsetDisplayBacklightButtonsView(handset: handset)
                                .navigationTitle("Buttons/Disp/B.light (HS\(handset.actualHandsetNumber))")
#if !os(macOS)
                                .navigationBarTitleDisplayMode(.inline)
#endif
                        } label: {
                            Label("Buttons/Display/Backlight", systemImage: "5.square")
                        }
                    }
                    if handset.supportsMessaging {
                        FormNavigationLink(phone: phone) {
                            HandsetMessagingView(handset: handset)
                                .navigationTitle("Msg-ing (HS\(handset.actualHandsetNumber))")
#if !os(macOS)
                                .navigationBarTitleDisplayMode(.inline)
#endif
                        } label: {
                            Label("Messaging", systemImage: "recordingtape")
                        }
                    }
                }
            }
        }
    }

    @ViewBuilder
    var audioGroup: some View {
        if let phone = handset.phone {
            Section("Audio") {
                FormNavigationLink(phone: phone) {
                    HandsetRingersView(handset: handset)
                        .navigationTitle("Ringers (HS\(handset.actualHandsetNumber))")
#if !os(macOS)
                        .navigationBarTitleDisplayMode(.inline)
#endif
                } label: {
                    Label("Ringers", systemImage: "bell")
                }
                FormNavigationLink(phone: phone) {
                    HandsetAudioView(handset: handset)
                        .navigationTitle("Spkr/Headset/Int (HS\(handset.actualHandsetNumber))")
#if !os(macOS)
                        .navigationBarTitleDisplayMode(.inline)
#endif
                } label: {
                    Label("Speakerphone/Headset/Intercom", systemImage: "speaker")
                }
            }
        }
    }

    @ViewBuilder
    var entriesGroup: some View {
        if let phone = handset.phone {
            Section("Entries") {
                if handset.handsetStyle < 3 {
                    FormNavigationLink(phone: phone) {
                        HandsetRedialView(handset: handset)
                            .navigationTitle("Redial (HS\(handset.actualHandsetNumber))")
#if !os(macOS)
                            .navigationBarTitleDisplayMode(.inline)
#endif
                    } label: {
                        Label("Redial", systemImage: "phone.arrow.up.right")
                    }
                }
                FormNavigationLink(phone: phone) {
                    HandsetPhonebookView(handset: handset)
                        .navigationTitle("P.book (HS\(handset.actualHandsetNumber))")
#if !os(macOS)
                        .navigationBarTitleDisplayMode(.inline)
#endif
                } label: {
                    Label("Phonebook", systemImage: "book")
                }
                FormNavigationLink(phone: phone) {
                    HandsetCallerIDView(handset: handset)
                        .navigationTitle("CID (HS\(handset.actualHandsetNumber))")
#if !os(macOS)
                        .navigationBarTitleDisplayMode(.inline)
#endif
                } label: {
                    Label("Caller ID", systemImage: "phone.bubble.left")
                }
                if handset.handsetStyle < 3 {
                    FormNavigationLink(phone: phone) {
                        HandsetSpeedDialView(handset: handset)
                            .navigationTitle("Quick Dial (HS\(handset.actualHandsetNumber))")
#if !os(macOS)
                            .navigationBarTitleDisplayMode(.inline)
#endif
                    } label: {
                        Label("Quick Dialing", systemImage: "person.3")
                    }
                }
            }
        }
    }

    @ViewBuilder
    var specialsGroup: some View {
        if let phone = handset.phone {
            Section {
                FormNavigationLink(phone: phone) {
                    HandsetSpecialFeaturesView(handset: handset)
                        .navigationTitle("Special (HS\(handset.actualHandsetNumber))")
#if !os(macOS)
                        .navigationBarTitleDisplayMode(.inline)
#endif
                } label: {
                    Label("Special Features", systemImage: "sparkle")
                }
            }
        }
    }

}

// MARK: - Preview

#Preview {
    @Previewable @State var handset = CordlessHandset(brand: "Panasonic", model: "KX-TGFA97", mainColorRed: 120, mainColorGreen: 120, mainColorBlue: 120, secondaryColorRed: 0, secondaryColorGreen: 0, secondaryColorBlue: 0, accentColorRed: 0, accentColorGreen: 0, accentColorBlue: 0)
    handset.phone = Phone(brand: "Panasonic", model: "KX-TGF975")
    return HandsetDetailView(handset: handset)
        .environmentObject(DialogManager())
}
