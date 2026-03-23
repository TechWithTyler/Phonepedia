//
//  DialogManager.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 9/25/24.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI

// Manages the display of dialogs in the app.
class DialogManager: ObservableObject {

    // MARK: - Properties - Selected Settings Page

#if os(macOS)
    // The page currently selected in the Settings window on macOS.
    @AppStorage(UserDefaults.KeyNames.selectedSettingsPage) var selectedSettingsPage: SettingsPage = .display
#endif

    // MARK: - Properties - Objects

    // The phone to be deleted.
    @Published var phoneToDelete: Phone? = nil

    // The phone to have its cordless devices' storageOrSetup properties updated.
    @Published var phoneToUpdateCordlessDevicePlaceInCollection: Phone? = nil

    // The cordless device to be deleted.
    @Published var handsetToDelete: CordlessHandset? = nil

    // The charger to be deleted.
    @Published var chargerToDelete: CordlessHandsetCharger? = nil

    // The cordless device to be reassigned to a different phone.
    @Published var handsetToReassign: CordlessHandset? = nil

    // MARK: - Properties - Booleans

    // Whether the "move failed" alert should be/is being displayed.
    @Published var showingMoveFailed: Bool = false

    // Whether the "update all cordless device place in collection" alert should be/is being displayed.
    @Published var showingUpdateCordlessDevicePlaceInCollection: Bool = false

    // Whether the "cordless device move failed" alert should be/is being displayed.
    @Published var showingMoveFailedHandset: Bool = false

    // Whether the cordless device reassignment sheet should be/is being displayed.
    @Published var showingReassignHandset: Bool = false

    // Whether the "about phone grades" sheet should be/is being displayed.
    @Published var showingAboutPhoneGrades: Bool = false

    // Whether the phone type definitions sheet should be/is being displayed.
    @Published var showingPhoneTypeDefinitions: Bool = false

    // Whether the "answering system vs voicemail" sheet should be/is being displayed.
    @Published var showingAnsweringSystemVsVoicemail: Bool = false

    // Whether the "about display types" sheet should be/is being displayed.
    @Published var showingAboutDisplayTypes: Bool = false

    // Whether the "delete this phone" alert should be/is being displayed.
    @Published var showingDeletePhone: Bool = false

    // Whether the "delete this cordless device" alert should be/is being displayed.
    @Published var showingDeleteHandset: Bool = false

    // Whether the "delete this charger" alert should be/is being displayed.
    @Published var showingDeleteCharger: Bool = false

    // Whether the "delete all phones" alert should be/is being displayed.
    @Published var showingDeleteAllPhones: Bool = false

    // Whether the "delete all cordless devices" alert should be/is being displayed.
    @Published var showingDeleteAllHandsets: Bool = false

    // Whether the "delete all chargers" alert should be/is being displayed.
    @Published var showingDeleteAllChargers: Bool = false

    // Whether the "make corded-only" alert should be/is being displayed.
    @Published var showingMakeCordedOnly: Bool = false

    // Whether the phone count sheet should be/is being displayed.
    @Published var showingPhoneCount: Bool = false

    // Whether the phone collection achievements sheet should be/is being displayed.
    @Published var showingPhoneCollectionAchievements: Bool = false

    // Whether the frequencies explanation sheet should be/is being displayed.
    @Published var showingFrequenciesExplanation: Bool = false

    // Whether the registration/security codes sheet should be/is being displayed.
    @Published var showingRegistrationExplanation: Bool = false

    // Whether the "about dialing codes" sheet should be/is being displayed.
    @Published var showingAboutDialingCodes: Bool = false

    // Whether the "about connection types" sheet should be/is being displayed.
    @Published var showingAboutConnectionTypes: Bool = false

    // Whether the "about caller ID name formatting" sheet should be/is being displayed.
    @Published var showingAboutCallerIDNameFormatting: Bool = false

    // Whether the PBX section in the "about connection types" sheet should be/is expanded.
    @Published var aboutPBXExpanded: Bool = false

    // Whether the settings sheet should be/is being displayed.
    #if !os(macOS)
    @Published var showingSettings: Bool = false
    #endif

    // MARK: - Show Dialogs

    func showDeletePhone(phone: Phone) {
        phoneToDelete = phone
        showingDeletePhone = true
    }

    func showUpdateCordlessDevicePlaceInCollection(phone: Phone) {
        showingUpdateCordlessDevicePlaceInCollection = true
        phoneToUpdateCordlessDevicePlaceInCollection = phone
    }

    func showDeleteHandset(handset: CordlessHandset) {
        showingDeleteHandset = true
        handsetToDelete = handset
    }

    func showDeleteCharger(charger: CordlessHandsetCharger) {
        showingDeleteCharger = true
        chargerToDelete = charger
    }

    func showReassignHandset(handset: CordlessHandset) {
        handsetToReassign = handset
        showingReassignHandset = true
    }

    // MARK: - Dismiss Dialog

    func dismissDeleteHandset() {
        handsetToDelete = nil
        showingDeleteHandset = false
    }

    func dismissDeleteCharger() {
        chargerToDelete = nil
        showingDeleteCharger = false
    }

}
