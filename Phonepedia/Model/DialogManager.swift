//
//  DialogManager.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 9/25/24.
//  Copyright © 2023-2024 SheftApps. All rights reserved.
//

import SwiftUI

// Manages the display of dialogs in the app.
class DialogManager: ObservableObject {

    // MARK: - Properties - Objects

    @Published var phoneToDelete: Phone? = nil

    @Published var handsetToDelete: CordlessHandset? = nil

    @Published var chargerToDelete: CordlessHandsetCharger? = nil

    // MARK: - Properties - Booleans

    @Published var showingPhoneTypeDefinitions: Bool = false

    @Published var showingAboutDisplayTypes: Bool = false

    @Published var showingDeletePhone: Bool = false

    @Published var showingDeleteHandset: Bool = false

    @Published var showingDeleteCharger: Bool = false

    @Published var showingDeleteAllPhones: Bool = false

    @Published var showingDeleteAllHandsets: Bool = false

    @Published var showingDeleteAllChargers: Bool = false

    @Published var showingPhoneCount: Bool = false

    @Published var showingFrequenciesExplanation: Bool = false

    @Published var showingRegistrationExplanation: Bool = false

    @Published var showingAboutDialingCodes: Bool = false

    @Published var showingAboutConnectionTypes: Bool = false

}
