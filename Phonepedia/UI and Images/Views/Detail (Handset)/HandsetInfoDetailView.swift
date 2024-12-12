//
//  HandsetInfoDetailView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 6/19/23.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct HandsetInfoDetailView: View {
    
    // MARK: - Properties - Handset
    
    @Bindable var handset: CordlessHandset
    
    // MARK: - Properties - Dialog Manager
    
    @EnvironmentObject var dialogManager: DialogManager
    
    // MARK: - Properties - Integers
    
    var handsetNumber: Int
    
    // MARK: - Body
    
    var body: some View {
        Form {
            Section {
                HandsetActionsView(handset: handset, handsetNumber: handsetNumber)
            }
            Section {
                FormNavigationLink("General") {
                    HandsetGeneralView(handset: handset)
                        .navigationTitle("General (HS\(handsetNumber))")
#if !os(macOS)
                        .navigationBarTitleDisplayMode(.inline)
#endif
                }
            }
                if handset.cordlessDeviceType < 2 {
                    Section {
                        FormNavigationLink("Ringers") {
                            HandsetRingersView(handset: handset)
                                .navigationTitle("Ringers (HS\(handsetNumber))")
                                #if !os(macOS)
                                .navigationBarTitleDisplayMode(.inline)
                                #endif
                        }
                    }
                    Section {
                        if handset.handsetStyle < 3 {
                            FormNavigationLink("Display/Backlight/Buttons") {
                                HandsetDisplayBacklightButtonsView(handset: handset)
                                    .navigationTitle("Disp/Backlight/Buttons (HS\(handsetNumber))")
#if !os(macOS)
                                    .navigationBarTitleDisplayMode(.inline)
#endif
                            }
                        }
                        FormNavigationLink("Audio") {
                            HandsetAudioView(handset: handset)
                                .navigationTitle("Audio (HS\(handsetNumber))")
                                #if !os(macOS)
                                .navigationBarTitleDisplayMode(.inline)
                                #endif
                        }
                        FormNavigationLink("Messaging") {
                            HandsetMessagingView(handset: handset)
                                .navigationTitle("Messaging (HS\(handsetNumber))")
                                #if !os(macOS)
                                .navigationBarTitleDisplayMode(.inline)
                                #endif
                        }
                    }
                    Section {
                        FormNavigationLink("Redial") {
                            HandsetRedialView(handset: handset)
                                .navigationTitle("Redial (HS\(handsetNumber))")
                                #if !os(macOS)
                                .navigationBarTitleDisplayMode(.inline)
                                #endif
                        }
                        FormNavigationLink("Phonebook") {
                            HandsetPhonebookView(handset: handset)
                                .navigationTitle("Phonebook (HS\(handsetNumber))")
                                #if !os(macOS)
                                .navigationBarTitleDisplayMode(.inline)
                                #endif
                        }
                        FormNavigationLink("Caller ID") {
                            HandsetCallerIDView(handset: handset)
                                .navigationTitle("Caller ID (HS\(handsetNumber))")
                                #if !os(macOS)
                                .navigationBarTitleDisplayMode(.inline)
                                #endif
                        }
                        FormNavigationLink("Speed Dial") {
                            HandsetSpeedDialView(handset: handset)
                                .navigationTitle("Speed Dial (HS\(handsetNumber))")
                                #if !os(macOS)
                                .navigationBarTitleDisplayMode(.inline)
                                #endif
                        }
                    }
                    Section {
                        FormNavigationLink("Special Features") {
                            HandsetSpecialFeaturesView(handset: handset)
                                .navigationTitle("Special Features (HS\(handsetNumber))")
                                #if !os(macOS)
                                .navigationBarTitleDisplayMode(.inline)
                                #endif
                        }
                    }
                }
            }
        .formStyle(.grouped)
    }
    
}

#Preview {
    @Previewable @State var handset = CordlessHandset(brand: "Panasonic", model: "KX-TGFA97", mainColorRed: 120, mainColorGreen: 120, mainColorBlue: 120, secondaryColorRed: 0, secondaryColorGreen: 0, secondaryColorBlue: 0)
    handset.phone = Phone(brand: "Panasonic", model: "KX-TGF975")
    return HandsetInfoDetailView(handset: handset, handsetNumber: 1)
        .environmentObject(DialogManager())
}
