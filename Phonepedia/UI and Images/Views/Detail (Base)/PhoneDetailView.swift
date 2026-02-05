//
//  PhoneDetailView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 6/16/23.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

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
                if phone.basePhoneType == 0 {
                    linesGroup
                }
                if phone.isCordless || phone.basePhoneType > 0 {
                    CordlessDeviceInfoView(phone: phone)
                }
                audioGroup
                entriesGroup
                if phone.isCordless || phone.isPushButtonCorded {
                    specialsGroup
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
            photoViewModel.handlePhotoPickerSelection(for: phone, newValue: newValue)
        })
        // Photo dialogs
#if os(iOS)
        .sheet(isPresented: $photoViewModel.takingPhoto) {
            CameraViewController(viewModel: photoViewModel, phone: phone)
        }
#endif
        .alert(isPresented: $photoViewModel.showingPhonePhotoErrorAlert, error: photoViewModel.phonePhotoError) {
            Button("OK") {
                photoViewModel.phonePhotoError = nil
            }
            .keyboardShortcut(.defaultAction)
        }
#if os(macOS)
        .dialogSeverity(.critical)
#endif
        .alert("This phone's photo has successfully been saved to your Photos library!", isPresented: $photoViewModel.showingPhonePhotoExportSuccessfulAlert) {
            Button("OK") {
                photoViewModel.showingPhonePhotoExportSuccessfulAlert = false
            }
        }
        .alert("Reset to the placeholder photo?", isPresented: $photoViewModel.showingResetAlert) {
            Button(role: .destructive) {
                phone.photoData = nil
            } label: {
                Text("Delete")
            }
            Button(role: .cancel) {
                photoViewModel.showingResetAlert = false
            } label: {
                Text("Cancel")
            }
        }
        .alert("This photo doesn't appear to contain landline or VoIP phones. Save anyway?", isPresented: $photoViewModel.showingUnsurePhotoDataAlert) {
            Button {
                phone.photoData = photoViewModel.unsurePhotoDataToUse
                photoViewModel.unsurePhotoDataToUse = nil
            } label: {
                Text("Save")
            }
            .keyboardShortcut(.defaultAction)
            Button(role: .cancel) {
                photoViewModel.unsurePhotoDataToUse = nil
            } label: {
                Text("Cancel")
            }
        } message: {
            Text("Tip: Landline/VoIP phone detection works best with photos where the phone takes up most of the photo.")
        }
    }
    
    // MARK: - Phone Photo/Actions
    
    @ViewBuilder
    var photoAndOptions: some View {
        Group {
            HStack {
                Spacer()
                PhoneImage(phone: phone, mode: .full)
                    .contextMenu {
                        Button("Save to Photos Library…", systemImage: "square.and.arrow.down") {
                            photoViewModel.savePhonePhotoToLibrary(phone: phone)
                        }
                        .disabled(phone.photoData == nil)
                    }
                    .onDrop(of: [.image], isTargeted: $photoViewModel.hoveringItemOverPhoto) { providers in
                        photoViewModel.handleDroppedPhoto(phone: phone, with: providers)
                    }
                    .onDrag {
                        photoViewModel.exportPhonePhoto(phone: phone)
                    }
                    .sensoryFeedback(.alignment, trigger: photoViewModel.hoveringItemOverPhoto)
                    .sensoryFeedback(.error, trigger: photoViewModel.showingPhonePhotoErrorAlert)
                Spacer()
            }
            if photoViewModel.hoveringItemOverPhoto {
                Text("Release to set photo")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            } else {
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
                InfoButton("Phone Type Definitions…") {
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
            if phone.basePhoneType == 0 {
                FormNavigationLink(phone: phone) {
                    PhonePowerView(phone: phone)
                        .navigationTitle("Power")
#if !os(macOS)
                        .navigationBarTitleDisplayMode(.inline)
#endif
                } label: {
                    Label("Power", systemImage: "bolt")
                }
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
            if phone.isCordless || phone.isPushButtonCorded || phone.basePhoneType > 0 {
                FormNavigationLink(phone: phone) {
                    BaseDisplayBacklightButtonsView(phone: phone)
                        .navigationTitle("Buttons/Disp/B.light")
#if !os(macOS)
                        .navigationBarTitleDisplayMode(.inline)
#endif
                } label: {
                    Label("Buttons/Display/Backlight", systemImage: "5.square")
                }
                if phone.basePhoneType == 0 {
                    FormNavigationLink(phone: phone) {
                        PhoneMessagingView(phone: phone)
                            .navigationTitle("Messaging")
#if !os(macOS)
                            .navigationBarTitleDisplayMode(.inline)
#endif
                    } label: {
                        Label("Messaging", systemImage: "recordingtape")
                    }
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
            if phone.isCordless || phone.isPushButtonCorded {
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
            if phone.isCordlessOrPushButtonDesk {
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
            if phone.canTalkOnBase {
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
            if phone.canShowPhoneNumbers {
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
                if phone.isCordlessOrPushButtonDesk {
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

    @ViewBuilder
    var specialsGroup: some View {
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

// MARK: - Preview

#Preview {
    PhoneDetailView(phone: Phone(brand: "AT&T", model: "CL83207"))
        .environmentObject(PhonePhotoViewModel())
        .environmentObject(DialogManager())
}
