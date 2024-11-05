//
//  FormNavigationLink.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 9/6/24.
//  Copyright © 2023-2024 SheftApps. All rights reserved.
//

import SwiftUI

struct FormNavigationLink<Destination: View, Label: View>: View {

    // MARK: - Properties - Dismiss Action

    @Environment(\.dismiss) var dismiss

    // MARK: - Properties - Destination

    var destination: Destination

    // MARK: - Properties - Label

    var label: Label

    // MARK: - Initialization

    init(@ViewBuilder destination: @escaping () -> Destination, @ViewBuilder label: @escaping () -> Label) {
        self.destination = destination()
        self.label = label()
    }

    init(_ label: String, @ViewBuilder destination: @escaping () -> Destination) where Label == Text {
        self.destination = destination()
        self.label = Text(label)
    }

    // MARK: - Body

    var body: some View {
        NavigationLink {
            Form {
                destination
            }
            .formStyle(.grouped)
        } label: {
            label
        }
    }
}

// MARK: - Preview

#Preview {
    FormNavigationLink("Navigation Link") {
        Text("I'm some text.")
    }
}
