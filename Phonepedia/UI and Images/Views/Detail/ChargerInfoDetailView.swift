//
//  ChargerInfoDetailView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 8/16/23.
//  Copyright © 2023-2024 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct ChargerInfoDetailView: View {
    
    // MARK: - Properties - Charger

	@Bindable var charger: CordlessHandsetCharger

    // MARK: - Properties - Dismiss Action

    @Environment(\.dismiss) var dismiss

    // MARK: - Properties - Integers

    let chargerNumber: Int

    // MARK: - Body

	var body: some View {
		if let phone = charger.phone {
			Form {
                Section {
                    Button {
                        phone.chargersIHave.insert(charger.duplicate(), at: chargerNumber)
                        dismiss()
                    } label: {
                        Label("Duplicate", systemImage: "doc.on.doc")
                    }
                    Button {
                        phone.chargersIHave.removeAll { $0 == charger }
                        dismiss()
                    } label: {
                        Label("Delete", systemImage: "trash")
#if !os(macOS)
                            .foregroundStyle(.red)
#endif
                    }
                    ColorPicker("Main Color", selection: charger.mainColorBinding)
                        ColorPicker("Secondary/Accent Color", selection: charger.secondaryColorBinding)
                        Button("Use Main Color") {
                            charger.setSecondaryColorToMain()
                        }
                    Picker("Charging Direction", selection: $charger.chargingDirection) {
                        Text("Forward (stand up)").tag(0)
                        Text("Forward (lean back)").tag(1)
                        Text("Forward (lay down)").tag(2)
                        Text("Backward (lay down)").tag(3)
                        Text("Backward (stand up)").tag(4)
                        Text("Backward (lean back)").tag(5)
                        Text("Forward Stand Up or Backward Lay Down").tag(6)
                        Text("Forward Or Backward (reversible handset)").tag(7)
                    }
                    Picker("Charge Contact Placement", selection: $charger.chargeContactPlacement) {
                        Text("Bottom").tag(0)
                        Text("Back").tag(1)
                        Text("One On Each Side").tag(2)
                    }
                    Picker("Charge Contact Type", selection: $charger.chargeContactType) {
                        Text("Press Down").tag(0)
                        Text("Click").tag(1)
                        Text("Inductive").tag(2)
                    }
                    ChargingContactInfoView()
                    Picker("Wall Mounting", selection: $charger.chargeContactType) {
                        Text("Not Supported").tag(0)
                        Text("Holes On Back").tag(1)
                        Text("Bracket").tag(2)
                    }
                }
                Section("Special Features") {
					if phone.supportsRangeExtenders {
						Toggle("Has Range Extender", isOn: $charger.hasRangeExtender)
                        InfoText("A charger with a built-in range extender allows you to have a range extender where you have a charger, without having to register and place a separate range extender.")
					}
                    
				}
			}
			.formStyle(.grouped)
		} else {
			Text("Error")
		}
	}
    
}

#Preview {
    @Previewable @State var charger = CordlessHandsetCharger()
    charger.phone = Phone(brand: "Panasonic", model: "KX-TGF675")
    return ChargerInfoDetailView(charger: charger, chargerNumber: 1)
}
