//
//  FormNavigationLink.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 9/6/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct FormNavigationLink<Destination: View, Label: View>: View {

    // MARK: - Properties - Destination

    var destination: Destination

    // MARK: - Properties - Label

    var label: Label

    // MARK: - Properties - Phone

    var phone: Phone

    // MARK: - Initialization

    init(phone: Phone, @ViewBuilder destination: @escaping () -> Destination, @ViewBuilder label: @escaping () -> Label) {
        self.destination = destination()
        self.label = label()
        self.phone = phone
    }

    init(_ label: String, phone: Phone, @ViewBuilder destination: @escaping () -> Destination) where Label == Text {
        self.destination = destination()
        self.label = Text(label)
        self.phone = phone
    }

    // MARK: - Body

    var body: some View {
        NavigationLink {
            SlickBackdropView {
                Form {
                    Section {
                        HStack {
                            Spacer()
                            PhoneImage(phone: phone, mode: .full)
                            Spacer()
                        }
                    }
                    destination
                }
                .formStyle(.grouped)
                .scrollContentBackground(.hidden)
            } backdropContent: {
                PhoneImage(phone: phone, mode: .backdrop)
            }
        } label: {
            label
        }
    }
}

// MARK: - Preview

#Preview {
    FormNavigationLink("Navigation Link", phone: Phone(brand: Phone.mockBrand, model: Phone.mockModel)) {
        Text("I'm some text.")
    }
}
