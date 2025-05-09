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
        SlickBackdropView {
        NavigationStack {
            Form {
                if photoViewModel.showingLoadingPhoto {
                    LoadingIndicator(message: "Loading photo…", style: .circular)
                } else {
                    photoAndOptions
                }
                basicsGroup
                linesGroup
                if phone.isCordless || phone.isWiFiHandset {
                    CordlessDeviceInfoView(phone: phone)
                }
                audioGroup
                entriesGroup
                if phone.isCordless || phone.cordedPhoneType == 0 {
                    FormNavigationLink(phone: phone) {
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
        } backdropContent: {
            PhoneImage(phone: phone, mode: .backdrop)
        }
        .scrollContentBackground(.hidden)
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
                PhoneImage(phone: phone, mode: .full)
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
                .onChange(of: phone.brand) { oldValue, newValue in
                    phone.brandChanged(oldValue: oldValue, newValue: newValue)
                }
            FormTextField("Model", text: $phone.model)
                .onChange(of: phone.model) { oldValue, newValue in
                    phone.modelNumberChanged(oldValue: oldValue, newValue: newValue)
                }
            HStack {
                Text("Phone Type")
                Spacer()
                Text(phone.phoneTypeText)
                InfoButton {
                    dialogManager.showingPhoneTypeDefinitions = true
                }
                .labelStyle(.iconOnly)
            }
            FormNavigationLink(phone: phone) {
                PhoneGeneralView(phone: phone)
                    .navigationTitle("General")
#if !os(macOS)
                    .navigationBarTitleDisplayMode(.inline)
#endif
            } label: {
                Label("General", systemImage: "gearshape")
            }
            FormNavigationLink(phone: phone) {
                PhonePowerView(phone: phone)
                    .navigationTitle("Power")
#if !os(macOS)
                    .navigationBarTitleDisplayMode(.inline)
#endif
            } label: {
                Label("Power", systemImage: "bolt")
            }
            FormNavigationLink(phone: phone) {
                PhoneColorView(phone: phone)
                    .navigationTitle(phone.isCordless ? "Base Colors" : "Colors")
#if !os(macOS)
                    .navigationBarTitleDisplayMode(.inline)
#endif
            } label: {
                Label(phone.isCordless ? "Base Colors" : "Colors", systemImage: "paintpalette")
            }
            if phone.isCordless || phone.cordedPhoneType == 0 || phone.cordedPhoneType == 2 {
                FormNavigationLink(phone: phone) {
                    BaseDisplayBacklightButtonsView(phone: phone)
                        .navigationTitle("Disp/B.light/Buttons")
#if !os(macOS)
                        .navigationBarTitleDisplayMode(.inline)
#endif
                } label: {
                    Label("Display/Backlight/Buttons", systemImage: "5.square")
                }
                    FormNavigationLink(phone: phone) {
                        PhoneMessagingView(phone: phone)
                            .navigationTitle("Messaging")
        #if !os(macOS)
                            .navigationBarTitleDisplayMode(.inline)
        #endif
                    } label: {
                        Label("Messaging", systemImage: "recordingtape")
                    }
                FormNavigationLink(phone: phone) {
                    PhoneOutgoingCallProtectionView(phone: phone)
                        .navigationTitle("Outgoing Protection")
#if !os(macOS)
                        .navigationBarTitleDisplayMode(.inline)
                    #endif
                } label: {
                    Label("Outgoing Call Protection", systemImage: "key.horizontal")
            }
            }
        }
        .formStyle(.grouped)
    }
    
    @ViewBuilder
    var audioGroup: some View {
        Section("Audio") {
            FormNavigationLink(phone: phone) {
                BaseRingersView(phone: phone)
                    .navigationTitle("Ringers")
#if !os(macOS)
                    .navigationBarTitleDisplayMode(.inline)
#endif
            } label: {
                Label("Ringers", systemImage: "bell")
            }
            if phone.isCordless || phone.cordedPhoneType == 0 {
                FormNavigationLink(phone: phone) {
                    BaseSpeakerphoneIntercomView(phone: phone)
                        .navigationTitle(phone.isCordless ? "Speaker/Int" : "Speakerphone")
#if !os(macOS)
                        .navigationBarTitleDisplayMode(.inline)
#endif
                } label: {
                    Label(phone.isCordless ? "Speakerphone/Intercom" : "Speakerphone", systemImage: "speaker")
                }
                FormNavigationLink(phone: phone) {
                    PhoneAudioView(phone: phone)
                        .navigationTitle(phone.landlineConnectionType > 0 ? "Headsets/Codecs" : "Headsets")
#if !os(macOS)
                        .navigationBarTitleDisplayMode(.inline)
#endif
                } label: {
                    Label(phone.landlineConnectionType > 0 ? "Headsets/Codecs" : "Headsets", systemImage: "headset")
                }
            }
            FormNavigationLink(phone: phone) {
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
        Section("Lines/Cell Phone Linking") {
            FormNavigationLink(phone: phone) {
                LandlineDetailView(phone: phone)
                    .navigationTitle("Main Line")
#if !os(macOS)
                    .navigationBarTitleDisplayMode(.inline)
#endif
            } label: {
                Label("Main Line", systemImage: "phone.connection")
            }
            if phone.isCordless || phone.cordedPhoneType == 0 {
                FormNavigationLink(phone: phone) {
                    CellPhoneLinkingView(phone: phone)
                        .navigationTitle("Cell Phone Linking")
#if !os(macOS)
                        .navigationBarTitleDisplayMode(.inline)
#endif
                } label: {
                    Label("Cell Linking", systemImage: "flipphone")
                }
            }
        }
    }
    
    @ViewBuilder
    var entriesGroup: some View {
        Section("Entries/Phone Numbers") {
            if phone.hasBaseSpeakerphone || !phone.isCordless || phone.isCordedCordless {
                FormNavigationLink(phone: phone) {
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
                FormNavigationLink(phone: phone) {
                    DialingCodesView(phone: phone)
                        .navigationTitle("Dialing Codes")
#if !os(macOS)
                        .navigationBarTitleDisplayMode(.inline)
#endif
                } label: {
                    Label("Dialing Codes (e.g., International, Area Code, Country Code)", systemImage: "numbers")
                }
                FormNavigationLink(phone: phone) {
                    BasePhonebookView(phone: phone)
                        .navigationTitle("Phonebook")
#if !os(macOS)
                        .navigationBarTitleDisplayMode(.inline)
#endif
                } label: {
                    Label("Phonebook", systemImage: "book")
                }
            }
            if phone.isCordless || phone.cordedPhoneType == 0 || (phone.cordedPhoneType == 2 && phone.baseDisplayType > 0) {
                FormNavigationLink(phone: phone) {
                    BaseCallerIDView(phone: phone)
                        .navigationTitle("Caller ID")
#if !os(macOS)
                        .navigationBarTitleDisplayMode(.inline)
#endif
                } label: {
                    Label("Caller ID", systemImage: "phone.bubble.left")
                }
                FormNavigationLink(phone: phone) {
                    BaseSpeedDialView(phone: phone)
                        .navigationTitle("Quick Dialing")
#if !os(macOS)
                        .navigationBarTitleDisplayMode(.inline)
#endif
                } label: {
                    Label("Quick Dialing", systemImage: "person.3")
                }
                if phone.isCordless || phone.cordedPhoneType == 0 {
                    FormNavigationLink(phone: phone) {
                        CallBlockView(phone: phone)
                            .navigationTitle("Call Blocking")
#if !os(macOS)
                            .navigationBarTitleDisplayMode(.inline)
#endif
                    } label: {
                        Label("Call Blocking", systemImage: "shield")
                    }
                }
            }
        }
    }
    
}

#Preview {
    PhoneDetailView(phone: Phone(brand: "AT&T", model: "CL83207"))
        .environmentObject(PhonePhotoViewModel())
        .environmentObject(DialogManager())
}
