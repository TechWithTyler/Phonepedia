//
//  PhoneCollectionAchievementTrackerViewModel.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 1/9/26.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//

// MARK: - Imports

import SwiftUI

class PhoneCollectionAchievementTrackerViewModel: ObservableObject {

    // MARK: - Properties - Booleans

    // Whether the achievement alert should be/is being displayed.
    @Published var showingAlert: Bool = false

    // Whether achievement alerts should show when unlocked.
    @AppStorage(UserDefaults.KeyNames.showAchievementAlerts) var showAchievementAlerts: Bool = true

    // MARK: - Properties - Strings

    // The title of the achievement alert.
    var alertTitle: String = String()

    var shownAchievementIDs: Set<String> = []

    var achievementTitles: Set<String> = []

    // MARK: - Evaluation

    // This method checks the given array of phones to check if any achievements have been unlocked.
    func evaluate(phones: [Phone], initialLoad shouldPerformInitialLoad: Bool = false) {
        DispatchQueue.main.async { [self] in
            // 1. Create an instance of PhoneCollectionAchievements with the current phones array.
            let model = PhoneCollectionAchievementTracker(phones: phones)
            achievementTitles.removeAll()
            // 2. Loop through each achievement.
            for item in model.all {
                // 3. If the achievement is unlocked and hasn't been shown, add it to the set of titles and shown IDs. If it becomes locked again, remove it from the shown IDs.
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
            // 4. If achievementTitles isn't empty (and not initial load), show the achievement alert.
            if !achievementTitles.isEmpty && !shouldPerformInitialLoad && showAchievementAlerts {
                let achievementsAnd = achievementTitles.formatted(.list(type: .and))
                let achievementsSingularOrPlural = achievementTitles.count == 1 ? "Achievement" : "Achievements"
                alertTitle = "\(achievementsSingularOrPlural) Unlocked! \(achievementsAnd)"
                showingAlert = true
            }
        }

    }
}

