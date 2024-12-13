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

    @AppStorage(UserDefaults.KeyNames.showNumberOfCordlessHandsetsInList) var showNumberOfCordlessHandsetsInList: Bool = true

    @AppStorage(UserDefaults.KeyNames.highlightHandsetNumberDigitInList) var highlightHandsetNumberDigitInList: Bool = true

    @AppStorage(UserDefaults.KeyNames.showPhoneColorsInList) var showPhoneColorsInList: Bool = true

    @AppStorage(UserDefaults.KeyNames.showYearsInList) var showYearsInList: Bool = true

    // MARK: - Properties - Phone

	@Bindable var phone: Phone
    
    // MARK: - Body

    var body: some View {
		HStack {
            PhoneImage(phone: phone, isThumbnail: true)
            Spacer()
            if showPhoneColorsInList {
                VStack {
                    colorCircle(for: phone.baseMainColorBinding.wrappedValue)
                    if phone.baseSecondaryColorBinding.wrappedValue != phone.baseMainColorBinding.wrappedValue {
                        colorCircle(for: phone.baseSecondaryColorBinding.wrappedValue)
                    }
                }
            }
            Spacer()
			VStack {
				Text(phone.brand)
					.font(.largeTitle)
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                Text(modelNumberWithColoredHandsetNumberDigit(phone.model, digit: phone.handsetNumberDigit, at: phone.handsetNumberDigitIndex))
					.font(.title2)
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                    .animation(.linear, value: phone.handsetNumberDigit)
                if !phone.nickname.isEmpty {
                    Text("\"\(phone.nickname)\"")
                        .font(.title3)
                        .lineLimit(nil)
                        .multilineTextAlignment(.center)
                }
                if showYearsInList {
                    if phone.acquisitionYear == phone.releaseYear {
                        Text("Released and purchased/acquired \(String(phone.acquisitionYear))")
                            .font(.callout)
                            .multilineTextAlignment(.center)
                            .lineLimit(nil)
                        if phone.acquisitionYear == phone.releaseYear {
                            HStack {
                                Image(systemName: "sparkle")
                                Text("Purchased/acquired the year it was released!")
                                    .font(.callout)
                                    .multilineTextAlignment(.center)
                                    .lineLimit(nil)
                            }
                        }
                    } else {
                        Text("Released \(String(phone.releaseYear))")
                            .font(.callout)
                            .multilineTextAlignment(.center)
                            .lineLimit(nil)
                        Text("Purchased/acquired \(String(phone.acquisitionYear))")
                            .font(.callout)
                            .multilineTextAlignment(.center)
                            .lineLimit(nil)
                    }
                }
                if showPhoneTypeInList {
                    Text(phone.phoneTypeText)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                if showNumberOfCordlessHandsetsInList && phone.isCordless {
                    if phone.numberOfIncludedCordlessHandsets == phone.cordlessHandsetsIHave.count {
                        Text("\(phone.numberOfIncludedCordlessHandsets) \(phone.numberOfIncludedCordlessHandsets == 1 ? "Cordless handset" : "Cordless devices")")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .lineLimit(nil)
                            .multilineTextAlignment(.center)
                    } else {
                        Text("\(phone.numberOfIncludedCordlessHandsets) \(phone.numberOfIncludedCordlessHandsets == 1 ? "Cordless handset included" : "cordless devices included")")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .lineLimit(nil)
                            .multilineTextAlignment(.center)
                        Text("\(phone.cordlessHandsetsIHave.count) \(phone.cordlessHandsetsIHave.count == 1 ? "cordless device in collection" : "cordless devices in collection")")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .lineLimit(nil)
                            .multilineTextAlignment(.center)
                    }
                }
                if showPhoneActiveStatusInList {
                    Text(phone.storageOrSetup > 1 ? "In storage" : "Active")
                        .foregroundStyle(.secondary)
                        .font(.subheadline)
                }
			}
			Spacer()
		}
    }

    @ViewBuilder
    func colorCircle(for color: Color) -> some View {
        Circle()
            .fill(color)
                   .overlay(
                       Circle()
                        .stroke(.primary, lineWidth: 1)
                   )
                   .frame(width: 10, height: 10)
    }

    // MARK: - Model Number "Number Of Included Cordless Devices" Digit Highlight

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

// MARK: - Preview

#Preview {
	PhoneRowView(phone: Phone(brand: "Panasonic", model: "KX-TGF975"))
        .modelContainer(for: Phone.self, inMemory: true)
}
