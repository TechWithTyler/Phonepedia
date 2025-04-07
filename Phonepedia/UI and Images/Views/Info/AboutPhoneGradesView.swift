//
//  AboutPhoneGradesView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 3/25/25.
//  Copyright © 2025 SheftApps. All rights reserved.
//

import SwiftUI

struct AboutPhoneGradesView: View {

    // MARK: - Properties - Dismiss Action

    @Environment(\.dismiss) var dismiss

    // MARK: - Properties - Dialog Manager

    @EnvironmentObject var dialogManager: DialogManager

    // MARK: - Body

    var body: some View {
        NavigationStack {
            Text("The grade specifies where the phone is designed to be used and determines the typical feature set. Expand the following sections to learn about each one.")
                .padding()
            List {
                DisclosureGroup {
                    Text("Residential and small business phones are designed for home and small business use. Some include features like speakerphone, quick dialing, caller ID, and answering systems.")
                } label: {
                    Text("Residential/Small Business Phone")
                }
                DisclosureGroup {
                    Text("Hotel phones are designed for hotel rooms. These phones look like residential phones but have additional features like one-touch dialing for hotel services (e.g. front desk, housekeeping, room service, restaurants, voicemail, wake-up call settings, emergency) and printed/displayed instructions for how to call different areas in the hotel or how to make outside calls.")
                    Text("To order one or more hotel phones, the hotel needs to download and fill out order forms from the phone manufacturer's website. These forms are filled out with the desired number of one-touch dial buttons and their default programming (reprogramming by the hotel staff is possible on most phones), as well as the room numbers and dialing instructions to be printed on the faceplate or programmed into the phone's default software configuration. The hotel then sends the forms to the manufacturer. For phones where customization of one-touch dials/dialing instructions/room number labels/faceplates isn't possible, the manufacturer takes care of this before shipping the phones to the hotel.")
                    Text("Because hotel phones are often customized with hotel-specific information, you may not be able to find one for your phone collection that wasn't previously ordered for a specific hotel.")
                    Text("Some hotels use residential phones in their rooms. You can use a residential phone on a hotel line and vice versa as long as their connection types are the same (e.g. an analog residential cordless phone on a hotel room's analog line).")
                } label: {
                    Text("Hotel Phone")
                }
                DisclosureGroup {
                    Text("Large business phones are designed for large businesses and organizations. These phones have features like multiple lines, speakerphone, quick dialing, caller ID, busy/available indication (Busy Lamp Field or BLF for short), call transfer, call parking (placing a call on hold at an extension and then picking it up by dialing it from another) and voicemail. Depending on the hotel and its rooms, large business phones may be used instead of hotel phones if those additional features are desired.")
                    Text("Large business phones are used with a PBX (Private Branch Exchange) phone system, which can be a physical device with line ports, or a computer or cloud-hosted system with phones and ATAs connected to it. See \"PBX\" in the \"About Connection Types\" dialog on the \"Main Line\" page to learn more.")
                    Button("Switch To \"About Connection Types/Devices\"…", systemImage: "arrow.right") {
                        dismiss()
                        dialogManager.showingAboutConnectionTypes = true
                        dialogManager.aboutPBXExpanded = true
                    }
                    .buttonStyle(.borderless)
                } label: {
                    Text("Large Business Phone")
                }
            }
            .navigationTitle("About Phone Grades")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Done")
                    }
                }
            }
        }
#if os(macOS)
        .frame(minWidth: 550, maxWidth: 550, minHeight: 350, maxHeight: 350)
#endif
    }
}

#Preview {
    AboutPhoneGradesView()
}
