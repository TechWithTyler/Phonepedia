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
                    }
                }
            }
            .formStyle(.grouped)
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
            }
            FormNavigationLink("Basic Features/Cordless Capabilities") {
                PhoneBasicFeaturesView(phone: phone)
            }
        }
        FormNavigationLink(phone.isCordless ? "Base Colors" : "Colors") {
            PhoneColorView(phone: phone)
        }
        .formStyle(.grouped)
        if phone.isCordless {
            PhonePartInfoView(phone: phone)
        }
        Section {
            FormNavigationLink("Power") {
                PhonePowerView(phone: phone)
            }
        }
    }
    
    @ViewBuilder
    var ringersAndMOHGroup: some View {
        Section {
            FormNavigationLink("Ringers") {
                BaseRingersView(phone: phone)
            }
            FormNavigationLink("Music/Message On Hold (MOH)") {
                PhoneMOHView(phone: phone)
            }
        }
    }
    
    @ViewBuilder
    var featurePhoneGroup: some View {
        Section {
            FormNavigationLink("Display/Backlight/Buttons") {
                BaseDisplayBacklightButtonsView(phone: phone)
            }
            FormNavigationLink("Answering System/Voicemail") {
                PhoneMessagingView(phone: phone)
            }
            FormNavigationLink("Audio Devices (e.g. headsets)") {
                PhoneAudioView(phone: phone)
            }
        }
    }
    
    @ViewBuilder
    var linesGroup: some View {
        Section {
            FormNavigationLink("Landline") {
                LandlineDetailView(phone: phone)
            }
            if phone.isCordless || phone.cordedPhoneType == 0 {
                FormNavigationLink("Cell Phone Linking") {
                    CellPhoneLinkingView(phone: phone)
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
                }
            }
            if phone.isCordless || (phone.cordedPhoneType == 0 && phone.baseDisplayType > 0) {
                FormNavigationLink("Dialing Codes (e.g., international, area code, country code)") {
                    DialingCodesView(phone: phone)
                }
                FormNavigationLink("Phonebook") {
                    BasePhonebookView(phone: phone)
                }
            }
            if phone.isCordless || phone.cordedPhoneType == 0 || phone.cordedPhoneType == 2 {
                FormNavigationLink("Caller ID") {
                    BaseCallerIDView(phone: phone)
                }
                FormNavigationLink("Speed Dial") {
                    BaseSpeedDialView(phone: phone)
                }
            }
        }
    }
    
    @ViewBuilder
    var callBlockingGroup: some View {
        Section {
            FormNavigationLink("Call Block (manual)") {
                CallBlockManualView(phone: phone)
            }
            FormNavigationLink("Call Block (pre-screening)") {
                CallBlockPreScreeningView(phone: phone)
            }
        }
    }
    
}

#Preview {
    PhoneDetailView(phone: Phone(brand: "AT&T", model: "CL83207"))
        .environmentObject(PhonePhotoViewModel())
        .environmentObject(DialogManager())
}
