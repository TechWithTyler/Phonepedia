//
//  HandsetInfoDetailView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 6/19/23.
//  Copyright © 2023-2024 SheftApps. All rights reserved.
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
                }
                if handset.cordlessDeviceType < 2 {
                    Section {
                        FormNavigationLink("Ringers") {
                            HandsetRingersView(handset: handset)
                        }
                    }
                    Section {
                        FormNavigationLink("Display/Backlight/Buttons") {
                            HandsetDisplayBacklightButtonsView(handset: handset)
                        }
                        FormNavigationLink("Audio") {
                            HandsetAudioView(handset: handset)
                        }
                        FormNavigationLink("Answering System/Voicemail") {
                            HandsetMessagingView(handset: handset)
                        }
                    }
                    Section {
                        FormNavigationLink("Redial") {
                            HandsetRedialView(handset: handset)
                        }
                        FormNavigationLink("Phonebook") {
                            HandsetPhonebookView(handset: handset)
                        }
                        FormNavigationLink("Caller ID") {
                            HandsetCallerIDView(handset: handset)
                        }
                        FormNavigationLink("Speed Dial") {
                            HandsetSpeedDialView(handset: handset)
                        }
                    }
                    Section {
                        FormNavigationLink("Special Features") {
                            HandsetSpecialFeaturesView(handset: handset)
                        }
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
