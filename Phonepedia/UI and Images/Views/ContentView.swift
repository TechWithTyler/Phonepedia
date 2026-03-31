//
//  ContentView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 6/15/23.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI
import SwiftData

struct ContentView: View {

    // MARK: - Properties - Objects

    // The model context, which stores data for Phonepedia documents.
    @Environment(\.modelContext) private var modelContext

    // Handles the display of dialogs in the app.
    @StateObject var dialogManager = DialogManager()

    // Handles playback of audio.
    @StateObject var audioManager = AudioManager()

    // Handles the import and export of phone photos.
    @StateObject var photoManager = PhonePhotoManager()

    @StateObject var achievementTrackerManager = PhoneCollectionAchievementTrackerManager()

    // MARK: - Properties - Phones

    // The Phone objects loaded from the document's model container.
    @Query(sort: \Phone.phoneNumberInCollection, order: .reverse) private var phones: [Phone]

    // The currently selected phone in the phone list.
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
        // Cordless device reassignment sheet
        .sheet(isPresented: $dialogManager.showingReassignHandset) {
            CordlessDeviceReassignmentView(phones: phones, selectedPhone: $selectedPhone)
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
        .formNumericTextFieldStepperVisible(true)
        // Model objects
        .environmentObject(dialogManager)
        .focusedSceneObject(dialogManager)
        .environmentObject(audioManager)
        .focusedSceneObject(audioManager)
        .environmentObject(photoManager)
        .focusedSceneObject(photoManager)
        .environmentObject(achievementTrackerManager)
        .focusedSceneObject(achievementTrackerManager)
    }

}

// MARK: - Preview

#Preview {
    ContentView()
        .modelContainer(for: [Phone.self, CordlessHandset.self, CordlessHandsetCharger.self], inMemory: true)
        .environmentObject(PhonePhotoManager())
        .environmentObject(DialogManager())
}
