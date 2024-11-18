//
//  PhoneGeneralView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/3/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct PhoneGeneralView: View {

    // MARK: - Properties - Objects

    @EnvironmentObject var dialogManager: DialogManager

    @Bindable var phone: Phone

    // MARK: - Properties - Booleans

    @AppStorage("phoneDescriptionTextSize") var phoneDescriptionTextSize: Double = SATextViewMinFontSize

    // MARK: - Body

    var body: some View {
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
        Toggle("Needed One or More Non-Battery Replacements", isOn: $phone.neededReplacements)
        InfoText("Sometimes, one or more parts of your phones may break or come broken and can't be fixed easily (e.g. broken base/handset speaker or display, corrupt memory on a base or handset that a factory reset can't fix, handsets unable to register/link to the base).\nYou can replace handsets easily just as you would purchase additional handsets, but you might end up with more parts than what you needed (e.g. you needed just a handset but also got a charger). To replace just a base or charger, you'll need to look on the used market or purchase an entire new phone set.\nIf you don't want to replace broken parts, you can try to send them to someone who can repair them, or if you know how to, repair it yourself.")
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
