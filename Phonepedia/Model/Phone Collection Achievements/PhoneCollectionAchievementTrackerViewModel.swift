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

    // Whether an evaluation is for the initial load of a phone catalog, where unlocked achievements are collected but not displayed until a new one is unlocked.
    @Published var shouldPerformInitialLoad: Bool = true

    // MARK: - Properties - Strings

    // The title of the achievement alert.
    var alertTitle: String = String()

    // MARK: - Shown Achievement IDs

    // Tracks which achievements have been shown. This prevents them from being displayed each time the alert is displayed.
    @Published var shownAchievementIDs: Set<String> = []

    // MARK: - Evaluation

    // This method checks the given array of phones to check if any achievements have been unlocked.
    func evaluate(phones: [Phone]) {
        // 1. Create an instance of PhoneCollectionAchievements with the current phones array.
        let model = PhoneCollectionAchievements(phones: phones)
        var achievementTitles: Set<String> = []
        DispatchQueue.main.async { [self] in
        // 2. Loop through each achievement.
        for item in model.all {
            // 3. If the achievement is unlocked and hasn't been shown, add it to the set of titles and shown IDs. If it becomes locked again, remove it from the shown IDs.
            if item.isUnlocked && !shownAchievementIDs.contains(item.id) {
                shownAchievementIDs.insert(item.id)
                if !shouldPerformInitialLoad {
                    achievementTitles.insert(item.title)
                }
            } else if !item.isUnlocked && shownAchievementIDs.contains(item.id) {
                    shownAchievementIDs.remove(item.id)
                achievementTitles.remove(item.title)
                }
            }
            // 4. If achievementTitles isn't empty and this isn't the initial load, show the achievement alert.
            if !achievementTitles.isEmpty && !shouldPerformInitialLoad {
                let achievementsAnd = achievementTitles.formatted(.list(type: .and))
                let achievementsSingularOrPlural = achievementTitles.count == 1 ? "Achievement" : "Achievements"
                alertTitle = "\(achievementsSingularOrPlural) Unlocked! \(achievementsAnd)"
                        showingAlert = true
            }
            // 5. If this was the initial load, set shouldPerformInitialLoad to false so the next check shows the alert. The initial load state is so that the achievements view model can get the "on load" states of any achievements that may have been shown previously.
            if shouldPerformInitialLoad {
                shouldPerformInitialLoad = false
            }
        }
    }

}

