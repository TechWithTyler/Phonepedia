//
//  PhoneCollectionStabilityView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 4/13/26.
//  Copyright © 2023-2026 SheftApps. All rights reserved.
//


import SwiftUI

struct PhoneCollectionStabilityView: View {

    var phones: [Phone]
    
    // MARK: - Computed Properties

    // The phones that are broken and currently needing replacements.
    var brokenPhones: [Phone] {
        return phones.filter { $0.isBrokenNeedingReplacements }
    }

    // How many phones are broken.
    var brokenCount: Int {
        return brokenPhones.count
    }

    // Shows the phone collection stability as a percentage.
    var stabilityScore: Double {
        guard !phones.isEmpty else { return 1.0 }
        return 1.0 - (Double(brokenCount) / Double(phones.count))
    }

    // The text for the stability indicator.
    var stabilityText: String {
        switch stabilityScore {
        case 1.0:
            return "Stable"
        case 0.7..<1.0:
            return "Mostly Stable"
        case 0.4..<0.7:
            return "Unstable"
        default:
            return "Critical"
        }
    }

    // The color for the stability indicator.
    private var stabilityColor: Color {
        switch stabilityScore {
        case 0.9...1.0:
            return .green
        case 0.7..<0.9:
            return .yellow
        case 0.4..<0.7:
            return .orange
        default:
            return .red
        }
    }

    // The text for the "phones needing replacement" label.
    private var replacementText: String {
        let phonesSingularOrPlural = brokenCount == 1 ? "phone" : "phones"
        return "\(brokenCount) \(phonesSingularOrPlural) needing non-accessory replacements."
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 12) {
            // Stability indicator
            VStack(spacing: 6) {
                Text("Collection Stability")
                    .font(.headline)
                Text(stabilityText)
                    .font(.title2)
                    .bold()
                    .foregroundColor(stabilityColor)
                ProgressView(value: stabilityScore)
                    .tint(stabilityColor)
            }
            // Count Label
            if !brokenPhones.isEmpty {
            Text(replacementText)
                .font(.subheadline)
                .foregroundColor(.secondary)
                VStack(alignment: .leading) {
                    ForEach(brokenPhones) { phone in
                        Text("• Phone \(phone.actualPhoneNumberInCollection) (\(phone.brand) \(phone.model))")
                    }
                }
            }
        }
        .padding()
    }
}
