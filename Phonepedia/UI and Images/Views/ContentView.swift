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

    @ObservedObject var dialogManager = DialogManager()

    @ObservedObject var audioManager = AudioManager()

    @ObservedObject var photoViewModel = PhonePhotoViewModel()

    @Query(sort: \Phone.phoneNumberInCollection, order: .reverse) private var phones: [Phone]

    @State var selectedPhone: Phone?

    // MARK: - Body

    var body: some View {
        NavigationSplitView {
            PhoneListView(phones: phones, selectedPhone: $selectedPhone)
                .navigationTitle("Phone List")
                .navigationSplitViewColumnWidth(min: 300, ideal: 350, max: 400)
                #if !os(macOS)
                .navigationBarTitleDisplayMode(.inline)
                #endif
        } detail: {
            if !phones.isEmpty {
                if let phone = selectedPhone {
                    PhoneDetailView(phone: phone)
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
        .sheet(isPresented: $dialogManager.showingAboutCordedPhoneStyles) {
            AboutCordedPhoneStylesView()
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
        // Model objects
        .environmentObject(dialogManager)
        .focusedSceneObject(dialogManager)
        .environmentObject(audioManager)
        .focusedSceneObject(audioManager)
        .environmentObject(photoViewModel)
        .focusedSceneObject(photoViewModel)
    }

}

#Preview {
    ContentView()
        .modelContainer(for: [Phone.self, CordlessHandset.self, CordlessHandsetCharger.self], inMemory: true)
        .environmentObject(PhonePhotoViewModel())
        .environmentObject(DialogManager())
}
