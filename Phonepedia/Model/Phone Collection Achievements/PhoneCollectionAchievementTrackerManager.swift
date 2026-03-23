//
//  PhoneCollectionAchievementTrackerManager.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 1/9/26.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI

class PhoneCollectionAchievementTrackerManager: ObservableObject {

    // MARK: - Properties - Booleans

    // Whether the achievement alert should be/is being displayed.
    @Published var showingAlert: Bool = false

    // Whether achievement alerts should show when unlocked.
    @AppStorage(UserDefaults.KeyNames.showAchievementAlerts) var showAchievementAlerts: Bool = true

    // MARK: - Properties - Strings

    // The title of the achievement alert.
    var alertTitle: String = String()

    // The set of IDs of achievements that have already been shown.
    var shownAchievementIDs: Set<String> = []

    // The set of titles of achievements to include in the alert.
    var achievementTitles: Set<String> = []

    // MARK: - Evaluation

    // This method checks the given array of phones to check if any achievements have been unlocked.
    func evaluate(phones: [Phone], initialLoad shouldPerformInitialLoad: Bool = false) {
        DispatchQueue.main.async { [self] in
            // 1. Create an instance of PhoneCollectionAchievements with the current phones array.
            let model = PhoneCollectionAchievementTracker(phones: phones)
            // 2. Clear the achievementTitles set.
            achievementTitles.removeAll()
            // 3. Loop through each achievement.
            for item in model.all {
                // 4. If the achievement is unlocked and hasn't been shown, add it to the set of titles and shown IDs. If it becomes locked again, remove it from the shown IDs.
                if item.isUnlocked && !shownAchievementIDs.contains(item.id) {
                    shownAchievementIDs.insert(item.id)
                    if !shouldPerformInitialLoad {
                        achievementTitles.insert(item.title)
                    }
                }
                if !item.isUnlocked && shownAchievementIDs.contains(item.id) {
                    shownAchievementIDs.remove(item.id)
                    achievementTitles.remove(item.title)
                }
            }
            // 5. If achievementTitles isn't empty, this isn't the initial load, and the setting to show achievement alerts is enabled, combine all achievements into an and list and show the achievement alert.
            if !achievementTitles.isEmpty && !shouldPerformInitialLoad && showAchievementAlerts {
                let achievementsAnd = achievementTitles.formatted(.list(type: .and))
                let achievementsSingularOrPlural = achievementTitles.count == 1 ? "Achievement" : "Achievements"
                alertTitle = "\(achievementsSingularOrPlural) Unlocked! \(achievementsAnd)"
                showingAlert = true
            }
        }

    }
}

