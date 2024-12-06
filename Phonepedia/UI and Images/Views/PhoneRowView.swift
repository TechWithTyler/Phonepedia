//
//  PhoneRowView.swift
//  Phonepedia
//
//  Created by Tyler Sheft on 6/16/23.
//  Copyright © 2023-2025 SheftApps. All rights reserved.
//

import SwiftUI

struct PhoneRowView: View {

    // MARK: - Properties - Booleans

    @AppStorage(UserDefaults.KeyNames.showPhoneTypeInList) var showPhoneTypeInList: Bool = true

    @AppStorage(UserDefaults.KeyNames.showPhoneActiveStatusInList) var showPhoneActiveStatusInList: Bool = true

    @AppStorage(UserDefaults.KeyNames.highlightHandsetNumberDigitInList) var highlightHandsetNumberDigitInList: Bool = true


    // MARK: - Properties - Phone

	@Bindable var phone: Phone
    
    // MARK: - Body

    var body: some View {
		HStack {
			Spacer()
			PhoneImage(phone: phone, isThumbnail: true)
			VStack {
				Text(phone.brand)
					.font(.largeTitle)
                Text(modelNumberWithColoredHandsetNumberDigit(phone.model, digit: phone.handsetNumberDigit, at: phone.handsetNumberDigitIndex))
					.font(.title2)
					.foregroundStyle(.secondary)
                    .lineLimit(nil)
                    .animation(.linear, value: phone.handsetNumberDigit)
                if !phone.nickname.isEmpty {
                    Text("\"\(phone.nickname)\"")
                }
                if showPhoneTypeInList {
                    Text(phone.phoneTypeText)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                if showPhoneActiveStatusInList {
                    Text(phone.storageOrSetup > 1 ? "In Storage" : "Active")
                        .foregroundStyle(.secondary)
                }
                if phone.acquisitionYear == phone.releaseYear {
                    HStack {
                        Image(systemName: "sparkle")
                        Text("Purchased/acquired the year it was released!")
                            .font(.callout)
                            .multilineTextAlignment(.center)
                            .lineLimit(nil)
                    }
                }
			}
			Spacer()
		}
    }

    func modelNumberWithColoredHandsetNumberDigit(_ modelNumber: String, digit: Int?, at index: Int?) -> AttributedString {
        // 1. Convert the model number String to an AttributedString. As AttributedString is a data type, it's declared in the Foundation framework instead of the SwiftUI framework, even though its cross-platform design makes it shine with SwiftUI. Unlike with NSAttributedString, you can simply initialize it with a String argument without having to use an argument label.
        var attributedString = AttributedString(modelNumber)
        // 2. Ensure digit and index aren't nil and that index is within modelNumber's bounds.
        if let digit = digit, let index = index, modelNumber.count > index, highlightHandsetNumberDigitInList {
            // 3. Calculate the String.Index for the given Int index.
            let stringIndex = modelNumber.index(modelNumber.startIndex, offsetBy: index)
            // 4. Check if the character at index matches digit.
            if modelNumber[stringIndex] == Character("\(digit)") {
                // 5. Calculate the range in AttributedString and apply highlighting.
                let attributedStartIndex = attributedString.index(attributedString.startIndex, offsetByCharacters: index)
                let attributedEndIndex = attributedString.index(afterCharacter: attributedStartIndex)
                attributedString[attributedStartIndex..<attributedEndIndex].backgroundColor = .accentColor
            }
        }
        // 6. Return the attributed string. If digit and index are nil, no highlighting is applied.
        return attributedString
    }

}

#Preview {
	PhoneRowView(phone: Phone(brand: "Panasonic", model: "KX-TGF975"))
        .modelContainer(for: Phone.self, inMemory: true)
}
