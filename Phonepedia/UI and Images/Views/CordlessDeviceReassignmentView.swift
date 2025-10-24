//
//  CordlessDeviceReassignmentView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 10/24/25.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI

struct CordlessDeviceReassignmentView: View {

    // MARK: - Dismiss Action

    @Environment(\.dismiss) var dismiss

    // MARK: - Properties - Objects

    @EnvironmentObject var dialogManager: DialogManager

    @State var selectedNewPhone: Phone? = nil

    var phones: [Phone]

    @Binding var selectedPhone: Phone?

    var compatiblePhones: [Phone] {
        guard let phone = dialogManager.handsetToReassign?.phone else { return phones }
        return phones
            .filter(
                { $0.isCordless && $0.frequency == phone.frequency && phone.isDigitalCordless && (
                    !$0.tooManyCordlessDevices || $0 == phone
                )
                })
            .sorted { $0.phoneNumberInCollection > $1.phoneNumberInCollection }
    }

    // MARK: - Body

    var body: some View {
        NavigationStack {
            Form {
                    List(selection: $selectedNewPhone) {
                        ForEach(compatiblePhones) { phone in
                            HStack {
                                let phoneText = "\(phone.phoneNumberInCollection + 1) - \(phone.brand) \(phone.model)"
                                PhoneImage(phone: phone, mode: .thumbnail)
                                Text(
                                    phone == dialogManager.handsetToReassign?.phone ? "\(phoneText) (Current)" : phoneText
                                )
                            }
                            .tag(phone)
                        }
                        .toolbar {
                            toolbarContent
                        }
                    }
                    .onAppear {
                        let currentPhone = dialogManager.handsetToReassign?.phone
                        selectedNewPhone = currentPhone
                    }
            }
            .navigationTitle("Assign To")
        }
        .frame(height: 400)
    }

    // MARK: - Toolbar

    @ToolbarContentBuilder
    var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
            Button("Cancel", role: .cancel) {
                dismissCordlessDeviceReassignment()
            }
        }
        ToolbarItem(placement: .confirmationAction) {
            Button("Assign") {
                reassignCordlessDevice()
            }
            .keyboardShortcut(.defaultAction)
            .disabled(selectedNewPhone == nil)
        }
    }

    // MARK: - Actions

    func reassignCordlessDevice() {
        // 1. Make sure we can get the selected phone, cordless device to reassign, and its old phone.
        if let selectedNewPhone = selectedNewPhone, let cordlessDevice = dialogManager.handsetToReassign, let oldPhone = cordlessDevice.phone {
            // 2. Make sure the selected phone isn't the old phone.
            guard selectedNewPhone != oldPhone else {
                dismissCordlessDeviceReassignment()
                return
            }
            // 3. Set the cordless device's number to 1 more than the last cordless device.
            cordlessDevice.handsetNumber = selectedNewPhone.cordlessHandsetsIHave.count
            // 4. Add the cordless device to the selected phone.
            selectedNewPhone.cordlessHandsetsIHave.append(cordlessDevice)
            // 4. Delete the cordless device from the old phone.
            oldPhone.cordlessHandsetsIHave.removeAll { $0 == cordlessDevice }
            // 5. Select the new phone.
            selectedPhone = selectedNewPhone
            // 6. Dismiss the sheet.
            dismissCordlessDeviceReassignment()
        }
    }

    func dismissCordlessDeviceReassignment() {
        dialogManager.handsetToReassign = nil
        dismiss()
    }

}

// MARK: - Preview

#Preview {
    CordlessDeviceReassignmentView(phones: [], selectedPhone: .constant(nil))
}
