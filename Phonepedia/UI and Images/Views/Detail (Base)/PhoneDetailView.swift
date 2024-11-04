//
//  PhoneDetailView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 6/16/23.
//  Copyright © 2023-2024 SheftApps. All rights reserved.
//

import SwiftUI
import SwiftData
import PhotosUI
import SheftAppsStylishUI

struct PhoneDetailView: View {
    
    // MARK: - Properties - Objects
    
    @Bindable var phone: Phone

    @EnvironmentObject var dialogManager: DialogManager

    @EnvironmentObject var photoViewModel: PhonePhotoViewModel

    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            Form {
                basicsGroup
                if phone.isCordless || phone.cordedPhoneType == 0 {
                    FormNavigationLink("Speakerphone/Intercom/Base Keypad") {
                        BaseSpeakerphoneKeypadView(phone: phone)
                            .navigationTitle("Spkr/Int/Base Keypad")
                            #if !os(macOS)
                            .navigationBarTitleDisplayMode(.automatic)
                            #endif
                    }
                }
                ringersAndMOHGroup
                if phone.isCordless || phone.cordedPhoneType == 0 {
                    featurePhoneGroup
                }
                linesGroup
                entriesGroup
                if phone.isCordless || phone.cordedPhoneType == 0 {
                    callBlockingGroup
                    FormNavigationLink("Special Features") {
                        PhoneSpecialFeaturesView(phone: phone)
                            .navigationTitle("Special Features")
                            #if !os(macOS)
                            .navigationBarTitleDisplayMode(.automatic)
                            #endif
                    }
                }
            }
            .formStyle(.grouped)
            .navigationTitle("\(phone.brand) \(phone.model)")
            #if !os(macOS)
            .navigationBarTitleDisplayMode(.automatic)
            #endif
        }
        .photosPicker(isPresented: $photoViewModel.showingPhotoPicker, selection: $photoViewModel.selectedPhoto, matching: .images, preferredItemEncoding: .automatic)
        .onChange(of: photoViewModel.selectedPhoto, { oldValue, newValue in
            photoViewModel.updatePhonePhoto(for: phone, oldValue: oldValue, newValue: newValue)
        })
#if os(iOS)
        .sheet(isPresented: $photoViewModel.takingPhoto) {
            CameraViewController(viewModel: photoViewModel, phone: phone)
        }
#endif
        .alert(isPresented: $photoViewModel.showingPhonePhotoErrorAlert, error: photoViewModel.phonePhotoError) {
            Button("OK") {
                photoViewModel.showingPhonePhotoErrorAlert = false
                photoViewModel.phonePhotoError = nil
            }
            .keyboardShortcut(.defaultAction)
        }
#if os(macOS)
        .dialogSeverity(.critical)
#endif
        .alert("Reset photo?", isPresented: $photoViewModel.showingResetAlert) {
            Button(role: .destructive) {
                phone.photoData = nil
                photoViewModel.showingResetAlert = false
            } label: {
                Text("Delete")
            }
            Button(role: .cancel) {
                photoViewModel.showingResetAlert = false
            } label: {
                Text("Cancel")
            }
        }
        .alert("Selected photo doesn't appear to contain landline phones. Save anyway?", isPresented: $photoViewModel.showingUnsurePhotoDataAlert) {
            Button {
                phone.photoData = photoViewModel.unsurePhotoDataToUse
                photoViewModel.unsurePhotoDataToUse = nil
                photoViewModel.showingUnsurePhotoDataAlert = false
            } label: {
                Text("Save")
            }
            .keyboardShortcut(.defaultAction)
            Button(role: .cancel) {
                photoViewModel.showingUnsurePhotoDataAlert = false
            } label: {
                Text("Cancel")
            }
        }
    }
    
    // MARK: - Detail Section Groups
    
    @ViewBuilder
    var basicsGroup: some View {
        Section {
            FormNavigationLink("General") {
                PhoneGeneralView(phone: phone)
                    .navigationTitle("General")
                    #if !os(macOS)
                    .navigationBarTitleDisplayMode(.automatic)
                    #endif
            }
            FormNavigationLink("Basic Features/Cordless Capabilities") {
                PhoneBasicFeaturesView(phone: phone)
                    .navigationTitle("Basics")
                    #if !os(macOS)
                    .navigationBarTitleDisplayMode(.automatic)
                    #endif
            }
        }
        FormNavigationLink(phone.isCordless ? "Base Colors" : "Colors") {
            PhoneColorView(phone: phone)
                .navigationTitle(phone.isCordless ? "Base Colors" : "Colors")
                #if !os(macOS)
                .navigationBarTitleDisplayMode(.automatic)
                #endif
        }
        .formStyle(.grouped)
        if phone.isCordless {
            PhonePartInfoView(phone: phone)
        }
        Section {
            FormNavigationLink("Power") {
                PhonePowerView(phone: phone)
                    .navigationTitle("Power")
                    #if !os(macOS)
                    .navigationBarTitleDisplayMode(.automatic)
                    #endif
            }
        }
    }
    
    @ViewBuilder
    var ringersAndMOHGroup: some View {
        Section {
            FormNavigationLink("Ringers") {
                BaseRingersView(phone: phone)
                    .navigationTitle("Ringers")
                    #if !os(macOS)
                    .navigationBarTitleDisplayMode(.automatic)
                    #endif
            }
            FormNavigationLink("Music/Message On Hold (MOH)") {
                PhoneMOHView(phone: phone)
                    .navigationTitle("MOH")
                    #if !os(macOS)
                    .navigationBarTitleDisplayMode(.automatic)
                    #endif
            }
        }
    }
    
    @ViewBuilder
    var featurePhoneGroup: some View {
        Section {
            FormNavigationLink("Display/Backlight/Buttons") {
                BaseDisplayBacklightButtonsView(phone: phone)
                    .navigationTitle("Disp/Backlight/Buttons")
                    #if !os(macOS)
                    .navigationBarTitleDisplayMode(.automatic)
                    #endif
            }
            FormNavigationLink("Messaging") {
                PhoneMessagingView(phone: phone)
                    .navigationTitle("Messaging")
                    #if !os(macOS)
                    .navigationBarTitleDisplayMode(.automatic)
                    #endif
            }
            FormNavigationLink("Audio Devices (e.g. headsets)") {
                PhoneAudioView(phone: phone)
                    .navigationTitle("Audio Devices")
                    #if !os(macOS)
                    .navigationBarTitleDisplayMode(.automatic)
                    #endif
            }
        }
    }
    
    @ViewBuilder
    var linesGroup: some View {
        Section {
            FormNavigationLink("Landline") {
                LandlineDetailView(phone: phone)
                    .navigationTitle("Landline")
                    #if !os(macOS)
                    .navigationBarTitleDisplayMode(.automatic)
                    #endif
            }
            if phone.isCordless || phone.cordedPhoneType == 0 {
                FormNavigationLink("Cell Phone Linking") {
                    CellPhoneLinkingView(phone: phone)
                        .navigationTitle("Cell Phone Linking")
                        #if !os(macOS)
                        .navigationBarTitleDisplayMode(.automatic)
                        #endif
                }
            }
        }
    }
    
    @ViewBuilder
    var entriesGroup: some View {
        Section {
            if phone.hasBaseSpeakerphone || !phone.isCordless || phone.isCordedCordless {
                FormNavigationLink("Redial") {
                    BaseRedialView(phone: phone)
                        .navigationTitle("Redial")
                        #if !os(macOS)
                        .navigationBarTitleDisplayMode(.automatic)
                        #endif
                }
            }
            if phone.isCordless || (phone.cordedPhoneType == 0 && phone.baseDisplayType > 0) {
                FormNavigationLink("Dialing Codes (e.g., international, area code, country code)") {
                    DialingCodesView(phone: phone)
                        .navigationTitle("Dialing Codes")
                        #if !os(macOS)
                        .navigationBarTitleDisplayMode(.automatic)
                        #endif
                }
                FormNavigationLink("Phonebook") {
                    BasePhonebookView(phone: phone)
                        .navigationTitle("Phonebook")
                        #if !os(macOS)
                        .navigationBarTitleDisplayMode(.automatic)
                        #endif
                }
            }
            if phone.isCordless || phone.cordedPhoneType == 0 || phone.cordedPhoneType == 2 {
                FormNavigationLink("Caller ID") {
                    BaseCallerIDView(phone: phone)
                        .navigationTitle("Caller ID")
                        #if !os(macOS)
                        .navigationBarTitleDisplayMode(.automatic)
                        #endif
                }
                FormNavigationLink("Speed Dial") {
                    BaseSpeedDialView(phone: phone)
                        .navigationTitle("Speed Dial")
                        #if !os(macOS)
                        .navigationBarTitleDisplayMode(.automatic)
                        #endif
                }
            }
        }
    }
    
    @ViewBuilder
    var callBlockingGroup: some View {
        Section {
            FormNavigationLink("Call Block (manual)") {
                CallBlockManualView(phone: phone)
                    .navigationTitle("Manual Call Block")
                    #if !os(macOS)
                    .navigationBarTitleDisplayMode(.automatic)
                    #endif
            }
            FormNavigationLink("Call Block (pre-screening)") {
                CallBlockPreScreeningView(phone: phone)
                    .navigationTitle("Call Block Pre-Screen")
                    #if !os(macOS)
                    .navigationBarTitleDisplayMode(.automatic)
                    #endif
            }
        }
    }
    
}

#Preview {
    PhoneDetailView(phone: Phone(brand: "AT&T", model: "CL83207"))
        .environmentObject(PhonePhotoViewModel())
        .environmentObject(DialogManager())
}
