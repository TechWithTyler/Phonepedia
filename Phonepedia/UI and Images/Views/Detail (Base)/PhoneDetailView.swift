//
//  PhoneDetailView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 6/16/23.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
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
                if photoViewModel.showingLoadingPhoto {
                    LoadingIndicator(message: "Loading photo…", style: .circular)
                } else {
                    photoAndOptions
                }
                basicsGroup
                linesGroup
                PhonePartInfoView(phone: phone)
                audioGroup
                entriesGroup
                if phone.isCordless || phone.cordedPhoneType == 0 {
                    callBlockingGroup
                    FormNavigationLink {
                        PhoneSpecialFeaturesView(phone: phone)
                            .navigationTitle("Special Features")
#if !os(macOS)
                            .navigationBarTitleDisplayMode(.inline)
#endif
                    } label: {
                        Label("Special Features", systemImage: "sparkle")
                    }
                }
            }
            .formStyle(.grouped)
            .navigationTitle("\(phone.brand) \(phone.model)")
#if !os(macOS)
            .navigationBarTitleDisplayMode(.inline)
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
        } message: {
            Text("Tip: Landline phone detection works best with images where the phone takes up most of the image.")
        }
    }
    
    // MARK: - Phone Photo/Actions
    
    @ViewBuilder
    var photoAndOptions: some View {
        Group {
            HStack {
                Spacer()
                PhoneImage(phone: phone, isThumbnail: false)
                Spacer()
            }
#if os(iOS)
            Button {
                photoViewModel.takingPhoto = true
            } label: {
                Label("Take Photo…", systemImage: "camera")
            }
#endif
            Button {
                photoViewModel.showingPhotoPicker = true
            } label: {
                Label("Select From Library…", systemImage: "photo")
            }
            Button(role: .destructive) {
                photoViewModel.showingResetAlert = true
            } label: {
                Label("Reset to Placeholder…", systemImage: "arrow.clockwise")
#if !os(macOS)
                    .foregroundStyle(.red)
#endif
            }
        }
    }
    
    // MARK: - Detail Section Groups
    
    @ViewBuilder
    var basicsGroup: some View {
        Section("Basics") {
            FormTextField("Brand", text: $phone.brand)
            FormTextField("Model", text: $phone.model)
                .onChange(of: phone.model) { _, _ in
                    phone.modelNumberChanged()
                }
            HStack {
                Text("Phone Type")
                Spacer()
                Text(phone.phoneTypeText)
                InfoButton {
                    dialogManager.showingPhoneTypeDefinitions = true
                }
            }
            FormNavigationLink {
                PhoneGeneralView(phone: phone)
                    .navigationTitle("General")
#if !os(macOS)
                    .navigationBarTitleDisplayMode(.inline)
#endif
            } label: {
                Label("General", systemImage: "gearshape")
            }
            FormNavigationLink {
                PhoneCordedCordlessFeaturesView(phone: phone)
                    .navigationTitle("Corded/Cordless")
#if !os(macOS)
                    .navigationBarTitleDisplayMode(.inline)
#endif
            } label: {
                Label("Corded/Cordless Features", systemImage: "phone")
            }
            FormNavigationLink {
                PhonePowerView(phone: phone)
                    .navigationTitle("Power")
#if !os(macOS)
                    .navigationBarTitleDisplayMode(.inline)
#endif
            } label: {
                Label("Power", systemImage: "bolt")
            }
            FormNavigationLink {
                PhoneColorView(phone: phone)
                    .navigationTitle(phone.isCordless ? "Base Colors" : "Colors")
#if !os(macOS)
                    .navigationBarTitleDisplayMode(.inline)
#endif
            } label: {
                Label(phone.isCordless ? "Base Colors" : "Colors", systemImage: "paintpalette")
            }
            if phone.isCordless || phone.cordedPhoneType == 0 {
                    FormNavigationLink {
                        BaseDisplayBacklightButtonsView(phone: phone)
                            .navigationTitle("Disp/Backlight/Buttons")
        #if !os(macOS)
                            .navigationBarTitleDisplayMode(.inline)
        #endif
                    } label: {
                        Label("Display/Backlight/Buttons", systemImage: "5.square")
                    }
                    FormNavigationLink {
                        PhoneMessagingView(phone: phone)
                            .navigationTitle("Messaging")
        #if !os(macOS)
                            .navigationBarTitleDisplayMode(.inline)
        #endif
                    } label: {
                        Label("Messaging", systemImage: "recordingtape")
                    }
            }
        }
        .formStyle(.grouped)
    }
    
    @ViewBuilder
    var audioGroup: some View {
        Section("Audio") {
            FormNavigationLink {
                BaseRingersView(phone: phone)
                    .navigationTitle("Ringers")
#if !os(macOS)
                    .navigationBarTitleDisplayMode(.inline)
#endif
            } label: {
                Label("Ringers", systemImage: "bell")
            }
            if phone.isCordless || phone.cordedPhoneType == 0 {
                FormNavigationLink {
                    BaseSpeakerphoneIntercomView(phone: phone)
                        .navigationTitle("Speaker/Int")
#if !os(macOS)
                        .navigationBarTitleDisplayMode(.inline)
#endif
                } label: {
                    Label("Speakerphone/Intercom", systemImage: "speaker")
                }
            }
            FormNavigationLink {
                PhoneAudioView(phone: phone)
                    .navigationTitle("Audio Devices")
#if !os(macOS)
                    .navigationBarTitleDisplayMode(.inline)
#endif
            } label: {
                Label("Audio Devices (e.g. Headsets)", systemImage: "headset")
            }
            FormNavigationLink {
                PhoneMOHView(phone: phone)
                    .navigationTitle("MOH")
#if !os(macOS)
                    .navigationBarTitleDisplayMode(.inline)
#endif
            } label: {
                Label("Music/Message On Hold (MOH)", systemImage: "music.quarternote.3")
            }
        }
    }
    
    @ViewBuilder
    var linesGroup: some View {
        Section("Lines") {
            FormNavigationLink {
                LandlineDetailView(phone: phone)
                    .navigationTitle("Landline")
#if !os(macOS)
                    .navigationBarTitleDisplayMode(.inline)
#endif
            } label: {
                Label("Landline", systemImage: "phone.connection")
            }
            if phone.isCordless || phone.cordedPhoneType == 0 {
                FormNavigationLink {
                    CellPhoneLinkingView(phone: phone)
                        .navigationTitle("Cell Phone Linking")
#if !os(macOS)
                        .navigationBarTitleDisplayMode(.inline)
#endif
                } label: {
                    Label("Cell Phone Linking", systemImage: "flipphone")
                }
            }
        }
    }
    
    @ViewBuilder
    var entriesGroup: some View {
        Section("Entries/Phone Numbers") {
            if phone.hasBaseSpeakerphone || !phone.isCordless || phone.isCordedCordless {
                FormNavigationLink {
                    BaseRedialView(phone: phone)
                        .navigationTitle("Redial")
#if !os(macOS)
                        .navigationBarTitleDisplayMode(.inline)
#endif
                } label: {
                    Label("Redial", systemImage: "phone.arrow.up.right")
                }
            }
            if phone.isCordless || (phone.cordedPhoneType == 0 && phone.baseDisplayType > 0) {
                FormNavigationLink {
                    DialingCodesView(phone: phone)
                        .navigationTitle("Dialing Codes")
#if !os(macOS)
                        .navigationBarTitleDisplayMode(.inline)
#endif
                } label: {
                    Label("Dialing Codes (e.g., International, Area Code, Country Code)", systemImage: "numbers")
                }
                FormNavigationLink {
                    BasePhonebookView(phone: phone)
                        .navigationTitle("Phonebook")
#if !os(macOS)
                        .navigationBarTitleDisplayMode(.inline)
#endif
                } label: {
                    Label("Phonebook", systemImage: "book")
                }
            }
            if phone.isCordless || phone.cordedPhoneType == 0 || phone.cordedPhoneType == 2 {
                FormNavigationLink {
                    BaseCallerIDView(phone: phone)
                        .navigationTitle("Caller ID")
#if !os(macOS)
                        .navigationBarTitleDisplayMode(.inline)
#endif
                } label: {
                    Label("Caller ID", systemImage: "phone.bubble.left")
                }
                FormNavigationLink {
                    BaseSpeedDialView(phone: phone)
                        .navigationTitle("Speed Dial")
#if !os(macOS)
                        .navigationBarTitleDisplayMode(.inline)
#endif
                } label: {
                    Label("Speed Dial", systemImage: "person.3")
                }
            }
        }
    }
    
    @ViewBuilder
    var callBlockingGroup: some View {
        Section("Call Block") {
            FormNavigationLink {
                CallBlockManualView(phone: phone)
                    .navigationTitle("Manual Call Block")
#if !os(macOS)
                    .navigationBarTitleDisplayMode(.inline)
#endif
            } label: {
                Label("Call Block (Manual)", systemImage: "phone.arrow.down.left")
            }
            FormNavigationLink {
                CallBlockPreScreeningView(phone: phone)
                    .navigationTitle("Call Block Pre-Screen")
#if !os(macOS)
                    .navigationBarTitleDisplayMode(.inline)
#endif
            } label: {
                Label("Call Block (Pre-Screening)" , systemImage: "shield")
            }
        }
    }
    
}

#Preview {
    PhoneDetailView(phone: Phone(brand: "AT&T", model: "CL83207"))
        .environmentObject(PhonePhotoViewModel())
        .environmentObject(DialogManager())
}
