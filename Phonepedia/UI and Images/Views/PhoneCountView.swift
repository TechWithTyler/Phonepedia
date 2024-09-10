//
//  PhoneCountView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 7/9/24.
//  Copyright © 2023-2024 SheftApps. All rights reserved.
//

import SwiftUI

struct PhoneCountView: View {

    var phones: [Phone]

    @Environment(\.dismiss) var dismiss

    // The total number of phones, not counting the individual cordless devices on each cordless phone system.
    var totalPhoneCount: Int {
        let count = phones.count
        return count
    }

    // The total number of cordless phones, not counting the individual cordless devices on each cordless phone system.
    var cordlessPhoneCount: Int {
        let count = phones.filter({ $0.isCordless }).count
        return count
    }

    // The total number of corded phones.
    var cordedPhoneCount: Int {
        let count = phones.filter({ !$0.isCordless }).count
        return count
    }

    // The total number of cordless handsets.
    var handsetCount: Int {
        var totalHandsets = 0
        for phone in phones.filter({$0.isCordless}) {
            totalHandsets += phone.cordlessHandsetsIHave.filter({$0.cordlessDeviceType == 0}).count
        }
        return totalHandsets
    }

    // The total number of cordless desksets.
    var desksetCount: Int {
        var totalDesksets = 0
        for phone in phones.filter({$0.isCordless}) {
            totalDesksets += phone.cordlessHandsetsIHave.filter({$0.cordlessDeviceType == 1}).count
        }
        return totalDesksets
    }

    // The total number of cordless handsets.
    var headsetCount: Int {
        var totalHeadsets = 0
        for phone in phones.filter({$0.isCordless}) {
            totalHeadsets += phone.cordlessHandsetsIHave.filter({$0.cordlessDeviceType == 2}).count
        }
        return totalHeadsets
    }

    // The total number of phones with answering systems.
    var withAnsweringSystemsCount: Int {
        let count = phones.filter({ $0.hasAnsweringSystem > 0 }).count
        return count
    }

    var body: some View {
        NavigationStack {
            List {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Total Phone Sets")
                            .foregroundStyle(.primary)
                            .multilineTextAlignment(.leading)
                        excludingHandsetsText
                    }
                    Spacer()
                    Text(totalPhoneCount, format: .number)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.trailing)
                }
                HStack {
                    VStack(alignment: .leading) {
                        Text("Cordless Phone Sets")
                            .foregroundStyle(.primary)
                            .multilineTextAlignment(.leading)
                        excludingHandsetsText
                    }
                    Spacer()
                    Text(cordlessPhoneCount, format: .number)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.trailing)
                }
                HStack {
                    Text("Corded Phones")
                        .foregroundStyle(.primary)
                        .multilineTextAlignment(.leading)
                    Spacer()
                    Text(cordedPhoneCount, format: .number)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.trailing)
                }
                HStack {
                    Text("With Answering Systems")
                        .foregroundStyle(.primary)
                        .multilineTextAlignment(.leading)
                    Spacer()
                    Text(withAnsweringSystemsCount, format: .number)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.trailing)
                }
                HStack {
                    Text("Cordless Handsets")
                        .foregroundStyle(.primary)
                        .multilineTextAlignment(.leading)
                    Spacer()
                    Text(handsetCount, format: .number)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.trailing)
                }
                HStack {
                    Text("Cordless Desksets")
                        .foregroundStyle(.primary)
                        .multilineTextAlignment(.leading)
                    Spacer()
                    Text(desksetCount, format: .number)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.trailing)
                }
                HStack {
                    Text("Cordless Headsets/Speakerphones")
                        .foregroundStyle(.primary)
                        .multilineTextAlignment(.leading)
                    Spacer()
                    Text(headsetCount, format: .number)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.trailing)
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Phone Count")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("OK") {
                        dismiss()
                    }
                    .keyboardShortcut(.defaultAction)
                }
            }
        }
#if os(macOS)
        .frame(minWidth: 550, maxWidth: 550, minHeight: 350, maxHeight: 350)
#endif
    }

    @ViewBuilder
    var excludingHandsetsText: some View {
        Text("Excluding individual handsets")
            .foregroundStyle(.secondary)
            .font(.footnote)
    }

}

#Preview {
    PhoneCountView(phones: [Phone(brand: "Panasonic", model: "KX-TG9582")])
}
