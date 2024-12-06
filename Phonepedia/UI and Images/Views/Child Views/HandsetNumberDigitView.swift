//
//  HandsetNumberDigitView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 12/3/24.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI
import SheftAppsStylishUI

struct HandsetNumberDigitView: View {

    @Bindable var phone: Phone

    var modelNumber: [Character] {
        return Array(phone.model)
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("Digit Representing Number Of Included Cordless Handsets")
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0..<modelNumber.count, id: \.self) { index in
                        if modelNumber[index].isNumber {
                            Button(String(modelNumber[index])) {
                                phone.handsetNumberDigit = Int(String(modelNumber[index]))
                                phone.handsetNumberDigitIndex = index
                                phone.numberOfIncludedCordlessHandsets = phone.handsetNumberDigit! == 0 ? 1 : phone.handsetNumberDigit!
                            }
                            .tint(phone.handsetNumberDigitIndex == index ? .accentColor : .primary)
                            .bold(phone.handsetNumberDigitIndex == index)
                            .padding(2.5)
                        } else {
                            Text(String(modelNumber[index]))
                                .padding(2.5)
                        }
                    }
                    Divider()
                    Button("None") {
                        phone.handsetNumberDigit = nil
                        phone.handsetNumberDigitIndex = nil
                    }
                    .tint(phone.handsetNumberDigitIndex == nil ? .accentColor : .primary)
                    .bold(phone.handsetNumberDigitIndex == nil)
                    .padding(2.5)
                }
                .animation(.linear, value: phone.handsetNumberDigit)
                .buttonStyle(.borderless)
            }
        }
        InfoText("The selected digit will be highlighted in the model number in the phone list.")
    }
}

#Preview {
    HandsetNumberDigitView(phone: Phone(brand: "Panasonic", model: "KX-TG1032"))
}
