//
//  ContentView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 6/15/23.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SwiftData

struct ContentView: View {

    // MARK: - Properties - Objects

    @Environment(\.modelContext) private var modelContext

    // MARK: - Properties - Dialog Manager

    @EnvironmentObject var dialogManager: DialogManager

    @Query(sort: \Phone.phoneNumberInCollection, order: .reverse) private var phones: [Phone]

    @State var selectedPhone: Phone?

    // MARK: - Body

    var body: some View {
        NavigationSplitView {
            PhoneListView(phones: phones, selectedPhone: $selectedPhone)
                .environmentObject(dialogManager)
                .navigationTitle("Phone List")
                #if os(macOS)
                .navigationSplitViewColumnWidth(min: 300, ideal: 350, max: 400)
                #else
                .navigationBarTitleDisplayMode(.inline)
                #endif
        } detail: {
            if !phones.isEmpty {
                if let phone = selectedPhone {
                    PhoneDetailView(phone: phone)
                        .environmentObject(dialogManager)
                } else {
                    NoPhoneSelectedView()
                }
            } else {
                EmptyView()
            }
        }
        // Info views
        .sheet(isPresented: $dialogManager.showingPhoneTypeDefinitions) {
            PhoneTypeDefinitionsView()
        }
        .sheet(isPresented: $dialogManager.showingAboutPhoneGrades) {
            AboutPhoneGradesView()
        }
        .sheet(isPresented: $dialogManager.showingAboutCallerIDNameFormatting) {
            AboutCallerIDNameFormattingView()
        }
        .sheet(isPresented: $dialogManager.showingAnsweringSystemVsVoicemail) {
            AnsweringSystemVsVoicemailView()
        }
        .sheet(isPresented: $dialogManager.showingAboutDisplayTypes) {
            AboutDisplayTypesView()
        }
        .sheet(isPresented: $dialogManager.showingFrequenciesExplanation) {
            FrequenciesExplanationView()
        }
        .sheet(isPresented: $dialogManager.showingRegistrationExplanation) {
            RegistrationExplanationView()
        }
        .sheet(isPresented: $dialogManager.showingAboutDialingCodes) {
            AboutDialingCodesView()
        }
        .sheet(isPresented: $dialogManager.showingAboutConnectionTypes) {
            AboutConnectionTypesView()
        }
        // iOS/visionOS settings view
        #if !os(macOS)
        .sheet(isPresented: $dialogManager.showingSettings) {
            SettingsView()
        }
        #endif
        .toggleStyle(.stateLabelCheckbox(stateLabelPair: .yesNo))
        .formNumericTextFieldStepperVisibility(true)
    }

}

#Preview {
    ContentView()
        .modelContainer(for: [Phone.self, CordlessHandset.self, CordlessHandsetCharger.self], inMemory: true)
        .environmentObject(PhonePhotoViewModel())
        .environmentObject(DialogManager())
}
