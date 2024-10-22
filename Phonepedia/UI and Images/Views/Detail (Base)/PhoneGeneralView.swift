//
//  PhoneGeneralView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2024 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct PhoneGeneralView: View {

    // MARK: - Properties - Objects

    @Bindable var phone: Phone

    @EnvironmentObject var photoViewModel: PhonePhotoViewModel

    @EnvironmentObject var dialogManager: DialogManager

    // MARK: - Properties - Booleans

    @AppStorage("phoneDescriptionTextSize") var phoneDescriptionTextSize: Double = SATextViewMinFontSize

    // MARK: - Body

    var body: some View {
        photoAndOptions
        FormTextField("Brand", text: $phone.brand)
        FormTextField("Model", text: $phone.model)
        HStack {
            Text("Phone Type")
            Spacer()
            Text(phone.phoneTypeText)
            InfoButton {
                dialogManager.showingPhoneTypeDefinitions = true
            }
        }
        Stepper("Release Year (-1 if unknown): \(String(phone.releaseYear))", value: $phone.releaseYear, in: -1...currentYear)
            .onChange(of: phone.releaseYear) { oldValue, newValue in
                phone.releaseYearChanged(oldValue: oldValue, newValue: newValue)
            }
        Stepper("Acquisition/Purchase Year (-1 if unknown): \(String(phone.acquisitionYear))", value: $phone.acquisitionYear, in: -1...currentYear)
            .onChange(of: phone.acquisitionYear) { oldValue, newValue in
                phone.acquisitionYearChanged(oldValue: oldValue, newValue: newValue)
            }
        if phone.acquisitionYear == phone.releaseYear && phone.acquisitionYear != -1 && phone.releaseYear != -1 {
            HStack {
                Image(systemName: "sparkle")
                Text("You got the \(String(phone.releaseYear)) \(phone.brand) \(phone.model) the year it was released!")
                    .font(.callout)
            }
        }
        Picker("How I Got This Phone", selection: $phone.whereAcquired) {
            Text("Thrift Store/Sale").tag(0)
            Text("Electronics Store (new)").tag(1)
            Text("Online (used)").tag(2)
            Text("Online (new)").tag(3)
            Text("Gift").tag(4)
        }
        Picker("Place In My Collection", selection: $phone.storageOrSetup) {
            PhoneInCollectionStatusPickerItems()
        }
        VStack {
            Text("Write more about your phone (e.g., the story behind why you got it, when/where you got it, whether you had to replace broken parts) in the text area below.")
                .lineLimit(nil)
            Stepper("Font Size: \(Int(phoneDescriptionTextSize))", value: $phoneDescriptionTextSize)
            ContrastingTextEditor(text: $phone.phoneDescription)
                .frame(minHeight: 300)
                .padding()
                .font(.system(size: phoneDescriptionTextSize))
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

}

// MARK: - Preview

#Preview {
    Form {
        PhoneGeneralView(phone: Phone(brand: "Panasonic", model: "KX-TGE263"))
            .environmentObject(DialogManager())
            .environmentObject(PhonePhotoViewModel())
    }
    .formStyle(.grouped)
}
